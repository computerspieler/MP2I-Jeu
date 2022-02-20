open Graphics
open LibRender

open GUIContainer
open GUIElements

exception StartGame
class playButton =
	object(_)
		inherit button (size_x() / 2) (size_y() / 2) 200 50 "Jouer :^)"

		method onClick =
			raise StartGame
	end

let menu_principal () =
	let container = new guiContainer in
	let title_img = Bitmap.readFileAndClose (open_in "res/title.bmp") in

	container#add (new imageBox (size_x() / 2) (size_y() - title_img.height / 2) title_img);
	container#add (new playButton);

	try
		while true do
			clear_graph();

			let ev = wait_next_event [Poll; Mouse_motion; Button_down] in

			container#update ev;
			container#render;

			synchronize();
			flush stdout;
			Unix.sleepf 0.01;
		done;
	with
	| StartGame -> ()
	| e -> raise e
