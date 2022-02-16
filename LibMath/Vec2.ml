type vec2 = {
	mutable x: int;
	mutable y: int;
}

let create i j =
	{x = i; y = j}

let print v =
	Printf.printf "(X: %d; Y: %d)\n%!" v.x v.y

let apply f v1 v2 =
	{ x = (f v1.x v2.x); y = (f  v1.y v2.y) }

let add = apply ( + )
let sub = apply ( - )
let mul = apply ( * )
let div = apply ( / )

let scalaire v1 v2 =
	let prod = mul v1 v2 in
	prod.x + prod.y

let length v =
	Int.of_float(Float.sqrt(
                Int.to_float(v.x * v.x + v.y * v.y)
        ))

let normalize v =
	let len = length v in
	if len = 0
	then { x = 0; y = 0 }
	else { x = v.x / len; y = v.y / len }


let apply_c f v c =
	{ x = (f v.x c); y = (f v.y c) }

let add_c = apply_c ( + )
let sub_c = apply_c ( - )
let mul_c = apply_c ( * )
let div_c = apply_c ( / )
