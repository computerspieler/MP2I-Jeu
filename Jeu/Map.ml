open LibRender

type tile = {
	img : Image.image option;

	isSolid : bool;
	isDeadly : bool;
}

let newTile (image_name: string option) isSolid isDeadly =
	let img =
		match image_name with
		| None -> None
		| Some name -> begin
			let path = "res/" ^ name ^ ".bmp" in
			Some (Bitmap.readFileAndClose (open_in path))
		end
	in
	{
		img = img;
		isSolid = isSolid;
		isDeadly = isDeadly;
	}

let tileSize = 64;;
let tileList = ref [||];;

let init_tileList () =
	tileList := [|
		newTile None			false	false;
		newTile (Some "test")	true	false;
		newTile (Some "spike")	true	true;
	|]

type map = {
	mutable scroll : int;		(* Scrolling horizontal *)
	
	height : int;
	chunck_width : int;	(* Sont en tiles, non en pixels *)
	width : int;		
	chunck : int array array;
}

let map_new_col (m : map) x =
	if x > m.width
	then Array.make m.height 0

	else if x = m.width
	then Array.make m.height 1

	else Array.init m.height (
		fun y ->
			if y < 1
			then 2
			else 0
	)

let map_init seed w h cw =
	Random.init seed;
	let m = {
		scroll = 0;
		height = h;

		width = w;
		chunck_width = cw;
		chunck = Array.make_matrix cw h 0;
	} in
	for i=0 to m.chunck_width - 1 do
		m.chunck.(i) <- map_new_col m i
	done;
	m

let scroll_chunck (m : map) =
	m.scroll <- m.scroll + 1;
	for i=1 to m.chunck_width - 1 do
		m.chunck.(i-1) <- m.chunck.(i)
	done;
	m.chunck.(m.chunck_width - 1) <-
		map_new_col m (m.chunck_width - 1 + m.scroll)

let draw (m : map) (sx : int) =
	for a = 0 to m.chunck_width - 1 do
		for b = 0 to m.height - 1 do
			match !tileList.(m.chunck.(a).(b)).img with
			| None -> ()
			| Some img ->
				Image.draw img
					(a * tileSize - sx) (b * tileSize)
		done
	done;