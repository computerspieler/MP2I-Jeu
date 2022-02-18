open Image
open Graphics

open GUIWidget

(*
	Les couleurs et le style
	utilisé pour le boutons proviennent
	du projet SerenityOS.
*)
class virtual button _cx _cy _w _h _text =
	object(_)
		inherit widget _cx _cy _w _h true

		val text : string = _text
		val text_dim = text_size _text

		val defaultBG = (rgb 192 192 192)
		val selectedBG = (rgb 210 210 210)

		val mutable background = (rgb 192 192 192)

		method render =
			(* La base du bouton *)
			set_color background;
			fill_rect x y width height;
			
			(* L'ombre *)
			set_color (rgb 64 64 64);
			draw_rect x y width height;

			set_color (rgb 128 128 128);
			moveto (x + width - 1) (y + 1);
			lineto (x + width - 1) (y + height - 1);
			moveto (x + width - 1) (y + 1);
			lineto (x + 1) (y + 1);

			(* La partie eclairé *)
			set_color (rgb 223 223 233);
			moveto x (y + height);
			lineto x (y + 1);
			moveto x (y + height);
			lineto (x + width) (y + height);

			(* Le texte *)
			let text_width, text_height = text_dim in
			set_color black;
			moveto
				(center_x - text_width  / 2)
				(center_y - text_height / 2);
			draw_string text;

		method onMouseEnter =
			background <- selectedBG;
			
		method onMouseExit =
			background <- defaultBG;

	end

class imageBox _cx _cy (_image : Image.image) =
	object(_)
		inherit widget _cx _cy _image.width _image.height false

		val image : Image.image = _image

		method render =
			draw image x y

		method onClick = ()
		method onMouseEnter = ()
		method onMouseExit = ()

	end