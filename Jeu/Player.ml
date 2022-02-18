open LibMath
open LibRender
open LibPhysics
open Graphics

class player init_image init_size init_y init_x = object(self)
	(*HYPOTHESES :  
	les tuiles ont une taille de coté ... map.tile_size
	direction de la carte et mouvements : 
	+ c'est le haut et la droite,
	- le bas et la gauche
	*)
	val mutable image = init_image
	val mutable size : Vec2.vec2 = {x = init_size; y = init_size}
	val mutable pos : Vec2.vec2 = {x = init_x; y = init_y}
	val mutable vel : Vec2.vec2 = {x = 0; y = 0}

	method gravity =
		vel.y <- vel.y - 1;

	method cap_speed =
		()

	method render = 
		Image.draw image pos.x pos.y

	method getPhysicsRect : rect =
		{
			position = pos;
			dimension = size;
			velocity = vel
		}

	method update (map : tilemap) (delta:float) = 
		ignore delta;
		if key_pressed()
			then begin
			match read_key() with
			| 'z' -> if isOnGround map self#getPhysicsRect then vel.y <- 20;
			| 'q' -> vel.x <- vel.x - 2;
			| 'd' -> vel.x <- vel.x + 2;
			| _ -> ();
		end;


		self#gravity;
		self#cap_speed;
		
		let new_pos, new_vel =
			(computeTilemapRectCollision map self#getPhysicsRect)
			in
		pos <- new_pos;
		vel <- new_vel;
end