open LibMath
open LibRender
open Graphics

open Map

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
	val mutable is_on_ground = false 

	method gravity = 
		vel.y <- vel.y - 1;

	method cap_speed =
		vel.x <- (clamp vel.x (-5) 5);
		vel.y <- (clamp vel.y (-20) 20)

	method render = 
		Image.draw image pos.x pos.y    

	method collision (map : map) = ()

	method update map = 
		if not (key_pressed())
		then vel.x <- 0
		else begin
			match (read_key()) with
			| 'z' ->
				if is_on_ground then begin
					vel.y <- vel.y + 8;
					is_on_ground <- false;
				end;
			| 'q' -> vel.x <- vel.x - 2;
			| 'd' -> vel.x <- vel.x + 2;
			| _ -> ()
		end;

		self#gravity;
		self#cap_speed;
		self#collision map;
		pos <- Vec2.add pos vel

	end