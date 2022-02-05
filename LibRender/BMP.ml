open Graphics

exception InvalidFile
exception InvalidFileFormat
exception InvalidFileVersion
exception CompressedFile
exception UnsupportedColorPalette
exception UnsupportedBPP

let get_int buffer offset size =
	let out = ref 0 in
	let pow_256 = ref 1 in
	for i=0 to size-1 do
		let b = int_of_char (Bytes.get buffer (offset+i)) in
		out := !out + b * !pow_256;
		pow_256 := !pow_256 * 256;
	done;
	!out

let retrieveDataFromHeader (ic:in_channel) =
	let header = Bytes.create 18 in
	
	if (input ic header 0 18) = 0
	then raise InvalidFile

	else if Bytes.get header 0 <> 'B' || Bytes.get header 1 <> 'M'
	then raise InvalidFileFormat;
	
	let start		= get_int header 10 4 in
	let header_len  = get_int header 14 4 in

	start, header_len

let retrieveDataFromDIBHeader (ic:in_channel) len =
	if len < 40
		then raise InvalidFile;

	let header = Bytes.create len in
	if (input ic header 0 len) = 0
		then raise InvalidFile;

	let width  = get_int header 0 4 in
	let height = get_int header 4 4 in
	let bpp    = get_int header 10 2 in

	Printf.printf "Head : %d %d %d \n%!" width height bpp;

	if get_int header 12 4 <> 0
	then raise CompressedFile

	else if get_int header 28 4 <> 0
	then raise UnsupportedColorPalette;

	width, height, bpp

let retreiveBitmap ic bmp_start width height bpp =
	let byte_per_pixel = bpp / 8 in
	let len = (width * height * bpp) / 8 in
	let buffer = Bytes.create len in

	seek_in ic bmp_start;
	if (input ic buffer 0 len) = 0
		then raise InvalidFile;

	let bitmap = Array.make_matrix height width 0 in

	for y = 0 to height-1 do
		for x = 0 to width-1 do
			let offset = (y * width + x) * byte_per_pixel in
			let r = int_of_char (Bytes.get buffer offset) in
			let g = int_of_char (Bytes.get buffer (offset+1)) in
			let b = int_of_char (Bytes.get buffer (offset+2)) in
			
			bitmap.(height - 1 - y).(x) <- (rgb r g b)
			done
	done;

	make_image bitmap

let readFile (ic:in_channel) = 
	try
		let bmp_start, header_len =
			retrieveDataFromHeader ic in
		let width, height, bpp =
			retrieveDataFromDIBHeader ic header_len in
		
		if bpp <> 32 && bpp <> 24
		then raise UnsupportedBPP;

		retreiveBitmap ic bmp_start width height bpp
	with
	End_of_file -> raise InvalidFile
	| e -> raise e

