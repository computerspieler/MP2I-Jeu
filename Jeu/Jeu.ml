open Graphics
open Unix

open Map

let event_mask =
	[Poll; Key_pressed]

let init() =
	open_graph " 640x480";
	set_window_title "Jeu";
	
	(* On active le double buffering *)
	display_mode false;
	remember_mode true;

	init_tileList()

let _ =
	init();

	let map = map_init 456 20 20 16 in
	let scroll = ref 0 in

	while true do
		clear_graph();

		draw map !scroll;
		incr scroll;

		if !scroll mod tileSize = 0
		then begin
			scroll := 0;
			scroll_chunck map
		end;
		synchronize ();
		
		sleepf 0.01;
	done
