open Image

(* Purement arbitraire *)
let transparent =
	Graphics.rgb 255 0 127;

type dibHeaderInfo = {
	width : int;
	height : int;
	bpp : int;
	colorPaletteCount : int;
	bitmap_start : int;
	header_len : int;
	bitfields_len : int;
}

let rec pow a n =
	if n <= 0 then 1
	else a * (pow a (n-1))

let getIntFromBuffer buffer offset size =
	let out = ref 0 in
	let pow_256 = ref 1 in
	for i=0 to size-1 do
		let b = int_of_char (Bytes.get buffer (offset+i)) in
		out := !out + b * !pow_256;
		pow_256 := !pow_256 * 256;
	done;
	!out

let getIntFromFile ic size =
	let out = ref 0 in
	let pow_256 = ref 1 in
	for i=0 to size-1 do
		ignore(i);
		let b = int_of_char (input_char ic) in
		out := !out + b * !pow_256;
		pow_256 := !pow_256 * 256;
	done;
	!out

let retrieveDataFromHeader (ic:in_channel) =
	let header = Bytes.create 18 in
	
	(* En-tête mal lu *)
	assert ((input ic header 0 18) = 18);

	(* En-tête invalide *)
	assert (Bytes.get header 0 = 'B' && Bytes.get header 1 = 'M');
	
	let start				= getIntFromBuffer header 10 4 in
	let header_len	= getIntFromBuffer header 14 4 in

	start, header_len

(* Genere un bitmap a partir d'un bitmap et d'une table de couleur *)
let generate (h : dibHeaderInfo) (bitmap:int array array) (colors:int array) =
	let computePixel x y =
		let raw_output =
			match colors with
			| [||] -> bitmap.(y).(x)
			| _ -> colors.(bitmap.(y).(x))
			in
		if raw_output = transparent
		then Graphics.transp
		else raw_output
	in
	Image.createNewMatrix h.width h.height computePixel

let retreiveRawBitmap (ic : in_channel) (h : dibHeaderInfo) =
	let byte_per_pixel = (h.bpp + 7) / 8 in
	let rowSize = ((h.width * h.bpp + 31) / 32) * 4 in

	Image.createNewMatrix h.width h.height
	(fun x y -> 
		let offset = (h.height - y - 1) * rowSize + ((h.bpp * x) / 8) in
		seek_in ic (h.bitmap_start + offset);

		let data = getIntFromFile ic byte_per_pixel in

		(* Que Dieu me pardonne *)
		let n = 8 - ((x*h.bpp) mod 8) - (min h.bpp 8) in
		let output = (data / (pow 2 n)) mod (pow 2 h.bpp) in

		output
	)

let retrieveColorTable (ic : in_channel) (h : dibHeaderInfo) =
	let entries_count =
		if h.colorPaletteCount <> 0
		then h.colorPaletteCount
		else pow 2 (h.bpp)
		in
	let entry_size = 4 in

	let len = entries_count * entry_size in
	let start = h.header_len + h.bitfields_len + 14 in

	let buffer = Bytes.create len in

	seek_in ic start;
	if (input ic buffer 0 len) = 0
		then raise InvalidFile;

	Array.init entries_count (fun i -> 
		let b = int_of_char(Bytes.get buffer (i * entry_size + 0)) in
		let g = int_of_char(Bytes.get buffer (i * entry_size + 1)) in
		let r = int_of_char(Bytes.get buffer (i * entry_size + 2)) in

		Graphics.rgb r g b
	)

let retrieveDataFromDIBHeader (ic:in_channel) len bmp_start =
	(* En-tête obselète *)
	assert(len >= 40);

	let header = Bytes.create len in

	(* En-tête mal lu *)
	assert((input ic header 0 len) = len);

	let compression = getIntFromBuffer header 12 4 in

	let algo_decompression = match compression with
	| 0 -> retreiveRawBitmap
        | 3 -> retreiveRawBitmap
        | 6 -> retreiveRawBitmap
        | _ -> failwith "Format non supporte"
	in

	let bitfields_len = match compression with
		| 3 -> 12
		| 6 -> 16
		| _ -> 0
	in

	{
		width  = getIntFromBuffer header  0 4;
		height = getIntFromBuffer header  4 4;
		bpp    = getIntFromBuffer header 10 2;
		colorPaletteCount = getIntFromBuffer header 28 4;
		bitmap_start = bmp_start;
		header_len = len;
		bitfields_len = bitfields_len;
	},
	algo_decompression

let readFile (ic:in_channel) = 
	try
		let bmp_start, header_len =
			retrieveDataFromHeader ic in
		let header, algo_decompression =
			retrieveDataFromDIBHeader ic header_len bmp_start in

		let bitmap = algo_decompression ic header in	
		let colorTable =
			if header.bpp <= 8 || header.colorPaletteCount <> 0
			then retrieveColorTable ic header
			else [||]
		in
		let output = generate (header) (bitmap) (colorTable) in
		{
			Image.image = Graphics.make_image output;
			width = header.width;
			height = header.height;
		}
	with
	End_of_file -> raise InvalidFile
	| e -> raise e	

let readFileAndClose (ic:in_channel) =
	let output = readFile ic in
	close_in ic;
	output
