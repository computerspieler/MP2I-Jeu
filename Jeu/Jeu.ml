open Graphics

open Game

let _ =
	(* On execute open_graph en premier car toutes les 
	   fonctions de Graphics ont besoin que cette
	   instruction ait été executé au préalable. *)
	open_graph " 1280x640";

	(* On active le double buffering *)
	display_mode false;
	remember_mode true;

	let actualRoom = ref (new gameRoom) in
	(!actualRoom)#init;

	let previous_time = ref (Unix.gettimeofday()) in
	while true do
		clear_graph();
		set_color (rgb 109 149 239);
		fill_rect 0 0 (size_x()) (size_y());

		(*
			On calcule le delta time, qui represente le temps
			écoulé entre deux mises à jour.
		*)
		let current_time = Unix.gettimeofday() in
		let delta_time = current_time -. !previous_time in
		previous_time := current_time;
		
		let ev = wait_next_event [Poll; Mouse_motion; Button_down] in
		(!actualRoom)#update ev delta_time;
		(!actualRoom)#render;
		
		synchronize();
		flush stdout;
		Unix.sleepf 0.05;

	done