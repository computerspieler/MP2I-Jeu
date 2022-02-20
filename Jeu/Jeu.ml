open Graphics
open LibRender

open Map
open Player

let _ =
	(* On execute open_graph en premier car de nombreuses 
	   fonctions relié (Bitmap.readFile, ...) ont besoin que cette
	   instruction ait été executé au préalable. *)
	open_graph " 1280x640";

	(* On active le double buffering *)
	display_mode false;
	remember_mode true;

	let player_img = Bitmap.readFileAndClose (open_in "res/spike.bmp") in
	let joueur = new player player_img 32 400 640 in 

	let terrain = Hashtbl.create 29 in 
		Hashtbl.add terrain "3"  (Bitmap.readFileAndClose (open_in "res/TileSet/3.bmp"));
		Hashtbl.add terrain "20000"  (Bitmap.readFileAndClose (open_in "res/TileSet/20000.bmp"));
		Hashtbl.add terrain "20001"  (Bitmap.readFileAndClose (open_in "res/TileSet/20001.bmp"));
		Hashtbl.add terrain "20010"  (Bitmap.readFileAndClose (open_in "res/TileSet/20010.bmp"));
		Hashtbl.add terrain "20011"  (Bitmap.readFileAndClose (open_in "res/TileSet/20011.bmp"));
		Hashtbl.add terrain "20100"  (Bitmap.readFileAndClose (open_in "res/TileSet/20100.bmp"));
		Hashtbl.add terrain "20101"  (Bitmap.readFileAndClose (open_in "res/TileSet/20101.bmp"));
		Hashtbl.add terrain "20110"  (Bitmap.readFileAndClose (open_in "res/TileSet/20110.bmp"));
		Hashtbl.add terrain "20111"  (Bitmap.readFileAndClose (open_in "res/TileSet/20111.bmp"));
		Hashtbl.add terrain "21000"  (Bitmap.readFileAndClose (open_in "res/TileSet/21000.bmp"));
		Hashtbl.add terrain "21001"  (Bitmap.readFileAndClose (open_in "res/TileSet/21001.bmp"));
		Hashtbl.add terrain "21010"  (Bitmap.readFileAndClose (open_in "res/TileSet/21010.bmp"));
		Hashtbl.add terrain "21011"  (Bitmap.readFileAndClose (open_in "res/TileSet/21011.bmp"));
		Hashtbl.add terrain "21100"  (Bitmap.readFileAndClose (open_in "res/TileSet/21100.bmp"));
		Hashtbl.add terrain "21101"  (Bitmap.readFileAndClose (open_in "res/TileSet/21101.bmp"));
		Hashtbl.add terrain "21110"  (Bitmap.readFileAndClose (open_in "res/TileSet/21110.bmp"));
		Hashtbl.add terrain "01010111"  (Bitmap.readFileAndClose (open_in "res/TileSet/01010111.bmp"));
		Hashtbl.add terrain "01011101"  (Bitmap.readFileAndClose (open_in "res/TileSet/01011101.bmp"));
		Hashtbl.add terrain "01011111"  (Bitmap.readFileAndClose (open_in "res/TileSet/01011111.bmp"));
		Hashtbl.add terrain "01110101"  (Bitmap.readFileAndClose (open_in "res/TileSet/01110101.bmp"));
		Hashtbl.add terrain "01111101"  (Bitmap.readFileAndClose (open_in "res/TileSet/01111101.bmp"));
		Hashtbl.add terrain "01111111"  (Bitmap.readFileAndClose (open_in "res/TileSet/01111111.bmp"));
		Hashtbl.add terrain "11010101"  (Bitmap.readFileAndClose (open_in "res/TileSet/11010101.bmp"));
		Hashtbl.add terrain "11010111"  (Bitmap.readFileAndClose (open_in "res/TileSet/11010111.bmp"));
		Hashtbl.add terrain "11011111"  (Bitmap.readFileAndClose (open_in "res/TileSet/11011111.bmp"));
		Hashtbl.add terrain "11110101"  (Bitmap.readFileAndClose (open_in "res/TileSet/11110101.bmp"));
		Hashtbl.add terrain "11110111"  (Bitmap.readFileAndClose (open_in "res/TileSet/11110111.bmp"));
		Hashtbl.add terrain "11111101"  (Bitmap.readFileAndClose (open_in "res/TileSet/11111101.bmp"));
		Hashtbl.add terrain "11111111"  (Bitmap.readFileAndClose (open_in "res/TileSet/11111111.bmp"));
    
	let carte = new map terrain 32 in 
	(*COMENTAIRE ICI !*)
	let camx = ref 640 in 
	let vit = ref 10 in

	let previous_time = ref (Unix.gettimeofday()) in
	while true do
		clear_graph();

		(*
		   On calcule le delta time, qui represente le temps
		   écoulé entre deux mises à jour.
		*)
		let current_time = Unix.gettimeofday() in
		let delta_time = current_time -. !previous_time in
		Printf.printf "Delta time : %f\n" delta_time;
		previous_time := current_time;

		carte#render !camx;
		joueur#render;
		joueur#update carte#getPhysicsTileMap delta_time !vit;
		camx := !camx + !vit;
    		
		synchronize();
		flush stdout;
		Unix.sleepf 0.01;
		done
