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

val drawOnCenter: image -> int -> int -> unit
val readFile: in_channel -> image