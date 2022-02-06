open LibMath
open Graphics
open LibRender
open Unix

let window_width, window_height =
	640, 480
;;

let event_mask =
	[Poll; Key_pressed]

let init() =
	let window_param = Printf.sprintf " %dx%d" window_width window_height in
	open_graph  window_param;
	set_window_title "Jeu";
	
	(* On active le double buffering *)
	display_mode false;
	remember_mode true

let _ =
	init();

	(* Il faut d'abord ouvrir le graph pour charger
		une image, sinon ça génère une Exception *)
	let f = open_in "res/test.bmp" in
	let img = Bitmap.readFile (f) in
	close_in f;

	let angle = ref 0 in
	while true do
		clear_graph();
		let ev = wait_next_event event_mask in
		if int_of_char ev.key <> 0
			then Printf.printf "%d\n%!" (int_of_char ev.key);
		
		Image.drawOnCenter img 100 100;
		(* A eviter, l'ideal est de précalculer les images à différents angles *)
		Image.drawOnCenter
			(ImageRotation.getRotatedImage img (to_radian (Int.to_float !angle)))
			100 100;
		
		incr angle;
		sleepf 0.03;

		synchronize ();
	done
