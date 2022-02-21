open Graphics

type image = {
	image: Graphics.image;
	width: int;
	height: int;
}

exception InvalidFile

let draw input x y =
	draw_image 
		input.image
		x y

let createNewMatrix width height f =
	Array.init height (
		fun y -> Array.init width (
			fun x -> f x y
		)
	)
