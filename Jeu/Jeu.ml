(* open LibMath *)
open Graphics
open LibRender
open Unix

let window_width, window_height =
	640, 480
;;

let event_mask =
	[Poll; Key_pressed]

let _ =
	let window_param = Printf.sprintf " %dx%d" window_width window_height in

	open_graph  window_param;
	
	let f = open_in "res/test.bmp" in
	let img = BMP.readFile (f) in
	close_in f;

	set_window_title "Jeu";
	draw_image img 0 0;
	while true do
		let ev = wait_next_event event_mask in
		if int_of_char ev.key <> 0
			then Printf.printf "%d\n%!" (int_of_char ev.key);

		sleepf 0.12;
	done;