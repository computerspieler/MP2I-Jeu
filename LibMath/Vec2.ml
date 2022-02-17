type vec2 = {
	mutable x: int;
	mutable y: int;
}

let create i j =
	{x = i; y = j}

let copy v =
	{x = v.x; y = v.y}
	
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

let length_squared v =
	v.x * v.x + v.y * v.y

let length v =
	Int.of_float(Float.sqrt(
		Int.to_float(length_squared v)
	))

let apply_c f v c =
	{ x = (f v.x c); y = (f v.y c) }

let add_c = apply_c ( + )
let sub_c = apply_c ( - )
let mul_c = apply_c ( * )
let div_c = apply_c ( / )
let ceil_div_c = apply_c (fun a b -> (a + b - 1) / b)

let addX v c = {x = v.x + c; y = v.y}
let subX v c = {x = v.x - c; y = v.y}
let mulX v c = {x = v.x * c; y = v.y}
let divX v c = {x = v.x / c; y = v.y}

let addY v c = {x = v.x; y = v.y + c}
let subY v c = {x = v.x; y = v.y - c}
let mulY v c = {x = v.x; y = v.y * c}
let divY v c = {x = v.x; y = v.y / c}

exception Done
let bresenham ps pe f =
	let d = create
		(abs pe.x - ps.x)
		(-abs(pe.y - ps.y))
		in

	let s = create
		(if ps.x < pe.x then 1 else -1)
		(if ps.y < pe.y then 1 else -1)
		in

	let p = copy ps in
	let err = ref (d.x + d.y) in

	try
		while true do
			match f p with
			| Some _ -> raise Done
			| None -> begin
				if p.x = pe.x && p.y = pe.y then raise Done;
				let e2 = 2 * !err in

				if e2 >= d.y then begin
					if p.x = pe.x then raise Done;
					err := !err + d.y;
					p.x <- p.x + s.x;
				end;

				if e2 <= d.x then begin
					if p.y = pe.y then raise Done;
					err := !err + d.x;
					p.y <- p.y + s.y;
				end
			end
		done;
		(f p)
	with
	| Done -> (f p)