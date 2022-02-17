open LibRender
open LibMath
open LibPhysics
open Graphics

class map i_carte i_terrain itilesize = object(self)
	val carte = i_carte
	val terrain = i_terrain
	val tile_size = itilesize

	method is_ground x y =
		(carte.(y).(x) = 1)

	method getPhysicsTileMap : tilemap =
		{
			size = Vec2.create (Array.length carte.(0)) (Array.length carte);
			tile_size = tile_size;

			collideFunction = self#is_ground;
		}

	method render = 
		Image.draw terrain 0 0

	method debugRender =
		for y = 0 to Array.length carte - 1 do
			for x = 0 to Array.length carte.(y) - 1 do
				set_color black;
				if self#is_ground x y
				then fill_rect (x * tile_size) (y * tile_size) tile_size tile_size;
				set_color red;
				draw_rect (x * tile_size) (y * tile_size) tile_size tile_size;
			done;
		done
end