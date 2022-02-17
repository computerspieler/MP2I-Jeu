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

let inside_map (t:tilemap) (v:Vec2.vec2) =
	(v.x >= 0 && v.x < t.size.x && v.y >= 0 && v.y < t.size.y)

let collideTileMapY (t : tilemap) (tilePos:Vec2.vec2) width =
	let output = ref false in
	let v = Vec2.copy tilePos in
	for i = 0 to (ceil_div width t.tile_size) do
		ignore(i);
		if (inside_map t v) && (t.collideFunction (v.x) (v.y))
		then output := true;
		v.x <- v.x + 1;
	done;
	!output

let collideTileMapX (t : tilemap) (tilePos:Vec2.vec2) height =
	let output = ref false in
	let v = Vec2.copy tilePos in
	for i = 0 to (ceil_div height t.tile_size) do
		ignore(i);
		if (inside_map t v) && (t.collideFunction (v.x) (v.y))
		then output := true;
		v.y <- v.y + 1;
	done;
	!output

let computeTilemapRectCollision (t : tilemap) (r:rect) =
	let pixel_to_travel_left = Vec2.create
		(abs (r.velocity.x))
		(abs (r.velocity.y))
		in
	let travel_direction = Vec2.create
		(if r.velocity.x < 0 then -1 else 1)
		(if r.velocity.y < 0 then -1 else 1)
		in
	
	let next_pos = Vec2.copy r.position in
	let next_vel = Vec2.copy r.velocity in

	let collision_test_offset = Vec2.create
		(if r.velocity.x <= 0 then 0 else r.dimension.x)
		(if r.velocity.y <= 0 then 0 else r.dimension.y)
		in

	(* NOTE: Cette algorithme est trop naïf. *)
	for a = 0 to (max (pixel_to_travel_left.x) (pixel_to_travel_left.y)) do
		ignore(a);
		(*
		Cette algorithme décale le rect d'un
		pixel vers la direction souhaité (velocity) sur l'axe X
		et verifier si le rect ne rentre pas en collision.
		Si c'est le cas, alors on ne peut aller plus loin, on s'arrete,
		sinon on décrémente le nombre de pixel a parcourir (pixel_to_travel_left).
		*)
		if pixel_to_travel_left.x > 0
		then begin
			next_pos.x <- next_pos.x + travel_direction.x + collision_test_offset.x;
			let tilePos = Vec2.div_c next_pos t.tile_size in
			
			if (collideTileMapX t tilePos r.dimension.y)
			then begin
				(pixel_to_travel_left.x <- 0);
				next_pos.x <- next_pos.x - travel_direction.x;
				next_vel.x <- 0;
			end
			else
				pixel_to_travel_left.x <- pixel_to_travel_left.x - 1;

			next_pos.x <- next_pos.x - collision_test_offset.x;
		end;

		(* Idem pour l'autre axe *)
		if pixel_to_travel_left.y > 0
		then begin
			next_pos.y <- next_pos.y + travel_direction.y + collision_test_offset.y;
			let tilePos = Vec2.div_c next_pos t.tile_size in
			
			if (collideTileMapY t tilePos r.dimension.x)
			then begin
				(pixel_to_travel_left.y <- 0);
				next_pos.y <- next_pos.y - travel_direction.y;
				next_vel.y <- 0;
			end
			else
				pixel_to_travel_left.y <- pixel_to_travel_left.y - 1;

			next_pos.y <- next_pos.y - collision_test_offset.y;
		end;
	done;
	next_pos, next_vel

let isOnGround (t:tilemap) (r:rect) =
	r.position.y <- r.position.y - 1;
	let tilePos = Vec2.div_c r.position t.tile_size in
	(collideTileMapY t tilePos r.dimension.x)