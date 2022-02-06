open Graphics
open Image

let getRotatedImage input angle =
	let color_matrix = dump_image input.image in
	let width, height =
		input.width, input.height
	in
	let cos_angle, sin_angle =
		Float.cos angle, Float.sin angle
		in
	let cy, cx =
		Int.to_float width /. 2.,
		Int.to_float height /. 2.
	in
	let new_size =
		Float.to_int(
			Float.sqrt(
				Int.to_float (width * width + height * height)
			)
		)
	in
	let new_cy, new_cx =
		new_size / 2,
		new_size / 2
	in
	let new_color_matrix =
		Array.make_matrix new_size new_size transp in
	
	for y = 0 to height - 1 do
		for x = 0 to width - 1 do
			let local_x, local_y = 
				Int.to_float x -. cx,
				Int.to_float y -. cy
				in
			(*
				Pour mieux comprendre ces formules,
				allez voir ce site :
				https://www.sciencedirect.com/topics/computer-science/image-rotation
			*)
			let new_x, new_y =
				Float.to_int (local_x *. cos_angle +. local_y *. sin_angle) + new_cx,
				Float.to_int (local_y *. cos_angle -. local_x *. sin_angle) + new_cy
				in
			if new_x >= 0 && new_x < new_size && new_y >= 0 && new_y < new_size
			then new_color_matrix.(new_y).(new_x) <- color_matrix.(y).(x);
		done
	done;
	{
		image = make_image new_color_matrix;
		width = new_size;
		height = new_size;
	}

let rec getRotatedImages input angles =
	match angles with
	| [] -> []
	| t::q -> (getRotatedImage input t)::(getRotatedImages input q)