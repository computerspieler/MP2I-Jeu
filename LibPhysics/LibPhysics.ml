open LibMath

type rect = {
	position : Vec2.vec2;
	dimension : Vec2.vec2;
	velocity : Vec2.vec2;
}

type tilemap = {
	size : Vec2.vec2;
	tile_size : int;

	collideFunction : int -> int -> bool;
}

let doAABBSweepCollision (d : rect) (s : rect) timeLeft =
	let xInvEntry, xInvExit =
		if d.velocity.x > 0
		then (s.position.x - (d.position.x + d.dimension.x)), ((s.position.x + s.dimension.x) - d.position.x)
		else ((s.position.x + s.dimension.x) - d.position.x), (s.position.x - (d.position.x + d.dimension.x))
		in
	let yInvEntry, yInvExit =
		if d.velocity.y > 0
		then (s.position.y - (d.position.y + d.dimension.y)), ((s.position.y + s.dimension.y) - d.position.y)
		else ((s.position.y + s.dimension.y) - d.position.y), (s.position.y - (d.position.y + d.dimension.y))
		in

	let xEntry, xExit =
		if d.velocity.x = 0
		then Stdlib.neg_infinity, Stdlib.infinity
		else (Int.to_float(xInvEntry) /. Int.to_float (d.velocity.x)),
			(Int.to_float(xInvExit)  /. Int.to_float (d.velocity.x))
		in
	let yEntry, yExit =
		if d.velocity.y = 0
		then Stdlib.neg_infinity, Stdlib.infinity
		else (Int.to_float(yInvEntry) /. Int.to_float (d.velocity.y)),
			(Int.to_float(yInvExit)  /. Int.to_float (d.velocity.y))
		in
	
	let entryTime = (Float.max xEntry yEntry) in
	let exitTime = (Float.min xExit yExit) in

	(* S'il n'y a pas de collisions *)
	if entryTime > exitTime || (xEntry < 0.0 && yEntry < 0.0) || xEntry > timeLeft || yEntry > timeLeft
	then
		timeLeft, Vec2.zero
	else begin
		let normalx, normaly =
			if xEntry > yEntry
			then
				if xInvEntry < 0
				then  1, 0
				else -1, 0
			else
				if yInvEntry < 0
				then 0, 1
				else 0, -1
			in
		
		entryTime, (Vec2.create normalx normaly)
	end

(*
	getTilePosition calcule la position sur la tilemap d'un
	point à partir de sa valeur "absolue" (en pixel).

	Et getAbsolutePosition est la réciproque de getTilePosition
*)
let getTilePosition (t:tilemap) (v:Vec2.vec2) =
	(Vec2.div_c v t.tile_size)

let getAbsolutePosition (t:tilemap) (v:Vec2.vec2) =
	(Vec2.mul_c v t.tile_size)

(* Permet de savoir si une tuile est solide *)
let tilemapIsSolid (t:tilemap) (v:Vec2.vec2) =
	(v.x >= 0 && v.x < t.size.x && v.y >= 0 && v.y < t.size.y) &&
	(t.collideFunction v.x v.y)

let getRaysIntersectionWithTilemap (t : tilemap) (dir:Vec2.vec2) (origin:Vec2.vec2) =
	Vec2.bresenham
		(getTilePosition t origin)
		(getTilePosition t (Vec2.add origin dir))
		(fun (v : Vec2.vec2) ->
			if tilemapIsSolid t v
			then (Some v)
			else None
		)

(*
	getCollidingTiles renvoie la liste des tuiles
	rentrant potentiellement en collision avec r.
	Pour cela, on lance des rayons a partir des tuiles
	autour de r, dans la direction de la vitesse de r.
*)
let getCollidingTiles (t : tilemap) (r:rect) =
	let start = Vec2.create
		(r.position.x - (if r.velocity.x < 0 then 1 else 0))
		(r.position.y - (if r.velocity.y < 0 then 1 else 0))
		in

	List.filter_map 
		(getRaysIntersectionWithTilemap t r.velocity)
		(
		(* Les tuiles du dessus *)
		List.init
			((ceil_div r.dimension.x t.tile_size) + 1)
			(fun i -> Vec2.create (start.x + i * t.tile_size) start.y)
		@
		(* Les tuiles du dessous *)
		List.init
			((ceil_div r.dimension.x t.tile_size) + 1)
			(fun i -> Vec2.create (start.x + i * t.tile_size) (start.y + r.dimension.y))
		@
		(* Les tuiles a gauche*)
		List.init
			((ceil_div r.dimension.y t.tile_size) + 1)
			(fun i -> Vec2.create start.x (start.y + i * t.tile_size))
		@
		(* Les tuiles a droite*)
		List.init
			((ceil_div r.dimension.y t.tile_size) + 1)
			(fun i -> Vec2.create (start.x + r.dimension.x) (start.y + i * t.tile_size))
		)

let rec computeMovingRectCollision (t : tilemap) (r : rect) (timeLeft : float) =
	let tiles = getCollidingTiles t r in

	if List.length tiles = 0 || timeLeft <= 0.0
	then (Vec2.add r.position r.velocity, r.velocity)
	else begin
		let s_collisionTime = ref timeLeft in
		let s_normal = ref Vec2.zero in

		List.iter (fun (v : Vec2.vec2) ->
			let collisionTime, normal = (doAABBSweepCollision
				{
					position = r.position;
					velocity = r.velocity;
					dimension = r.dimension;
				}
				{
					position = getAbsolutePosition t v;
					velocity = Vec2.zero;
					dimension = Vec2.create t.tile_size t.tile_size;
				} timeLeft)
				in
			if collisionTime < !s_collisionTime
			then begin
				s_collisionTime := collisionTime;
				s_normal := normal;
			end;
		) tiles;

		if !s_collisionTime >= timeLeft
		then (Vec2.add r.position r.velocity, r.velocity)
		else
			let new_pos = Vec2.add
				r.position
				(Vec2.create
					(Int.of_float ((Int.to_float r.velocity.x) *. !s_collisionTime))
					(Int.of_float ((Int.to_float r.velocity.y) *. !s_collisionTime))
				)
				in
			
			let remainingTime = (timeLeft -. !s_collisionTime) in
			let magnitude = Int.of_float
				(Int.to_float (Vec2.length r.velocity) *. remainingTime)
				in
			let dotprod =
				sign (r.velocity.x * !s_normal.y + r.velocity.y * !s_normal.x)
				in

			computeMovingRectCollision t
			{
				position = new_pos;
				velocity =
					Vec2.create
					(dotprod * !s_normal.y * magnitude)
					(dotprod * !s_normal.x * magnitude);
				dimension = r.dimension;
			}
			remainingTime
	end


let computeTilemapRectCollision (t : tilemap) (r:rect) =
	if (r.velocity.x = 0 && r.velocity.y = 0)
	then (r.position, r.velocity)
	else (computeMovingRectCollision t r 1.0)

let isOnGround (t : tilemap) (r : rect) =
	let output = ref false in
	let pos_underneath = getTilePosition t (Vec2.subY r.position 1) in
	for i = 0 to (ceil_div r.dimension.x t.tile_size) do
		if tilemapIsSolid t (Vec2.addX pos_underneath i)
		then output := true;
	done;
	!output