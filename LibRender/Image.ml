open Graphics

type image = {
	image: Graphics.image;
	width: int;
	height: int;
}

exception InvalidFile
exception InvalidFileFormat
exception InvalidFileVersion
exception CompressedFile
exception UnsupportedColorPalette
exception UnsupportedBPP

let drawOnCenter input x y =
	draw_image 
		input.image
		(x - input.width / 2)
		(y - input.height / 2)

let createNewColorMatrix width height f =
	Array.init height (
		fun y -> Array.init width (
			fun x -> f x y
		)
	)