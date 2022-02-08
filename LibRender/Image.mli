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

val draw: image -> int -> int -> unit
val drawOnCenter: image -> int -> int -> unit
val createNewColorMatrix: int -> int -> (int -> int -> Graphics.color) -> Graphics.color array array