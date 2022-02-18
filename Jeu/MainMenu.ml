open Graphics
open LibRender

open GUIContainer
open GUIElements
open Exceptions
open Room

class playButton =
	object(_)
		inherit button (size_x() / 2) (size_y() / 2) 200 50 "Jouer :^)"

		method onClick =
			raise StartGame
	end

class mainMenu =
	object(_)
		inherit room

		val container = new guiContainer
		val title_img = Bitmap.readFileAndClose (open_in "res/title.bmp")
	
	method init =
		container#add
			(new imageBox (size_x() / 2) (size_y() - title_img.height / 2) title_img);
		container#add
			(new playButton);

	method update (ev : status) (delta : float) =
		ignore delta;
		container#update ev

	method render =
		container#render

	end