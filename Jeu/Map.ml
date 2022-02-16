open LibRender
open Graphics

class map i_carte i_terrain itilesize = object(self)
	val carte = i_carte
	val terrain = i_terrain
	val mutable tile_size = itilesize

	method is_in x y = 
		y >= 0 && y < Array.length carte &&
		x >= 0 && x < Array.length carte.(y)

	method is_ground x y =
		if not (self#is_in x y) then false
		else (carte.(y).(x) = 1)

	method tile_size : int = tile_size

	method does_row_has_ground y x1 x2 =
		let output = ref false in
		for x = x1 to x2 do
			if self#is_ground x y
			then output := true;
		done;
		!output

	method does_col_has_ground x y1 y2 =
		let output = ref false in
		for y = y1 to y2 do
			if self#is_ground x y
			then output := true;
		done;
		!output

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