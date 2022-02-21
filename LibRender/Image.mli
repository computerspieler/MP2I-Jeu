type image = {
	image: Graphics.image;
	width: int;
	height: int;
}

exception InvalidFile

val draw: image -> int -> int -> unit
val createNewMatrix: int -> int -> (int -> int -> Graphics.color) -> Graphics.color array array
