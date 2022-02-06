open Graphics
open Image

let compute_rotated_pixel color_matrix width height new_size angle x y =
	let cos_angle, sin_angle =
		Float.cos angle, Float.sin angle
		in
	
	(* On calcule la position du pixel par
		rapport au centre de rotation *)
	let dest_c = Int.to_float (new_size / 2) in
	let dest_x, dest_y = 
		Int.to_float x -. dest_c,
		Int.to_float y -. dest_c
		in
	
	(*
		Pour mieux comprendre ces formules,
		allez voir ce site :
		https://www.sciencedirect.com/topics/computer-science/image-rotation
	*)
	let src_x, src_y =
		Float.to_int (dest_x *. cos_angle +. dest_y *. sin_angle) + (width  / 2),
		Float.to_int (dest_y *. cos_angle -. dest_x *. sin_angle) + (height / 2)
		in

	if src_x >= 0 && src_x < width && src_y >= 0 && src_y < height
	then color_matrix.(src_y).(src_x)
	else transp

let getRotatedImage input angle =
	let color_matrix = dump_image input.image in
	let new_size =
		Float.to_int(Float.sqrt(
			Int.to_float (input.width * input.width + input.height * input.height)
		))
	in
	let new_color_matrix = Image.createNewColorMatrix new_size new_size
		(compute_rotated_pixel
			color_matrix input.width input.height
			new_size
			(-. angle)
		)
	in
	{
		image = make_image new_color_matrix;
		width = new_size;
		height = new_size;
	}

let rec getRotatedImages input angles =
	match angles with
	| [] -> []
	| t::q -> (getRotatedImage input t)::(getRotatedImages input q)