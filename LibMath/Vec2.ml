type vec2 = {
        mutable x: float;
        mutable y: float;
}

let create i j =
        {x = i; y = j}

let print v =
        Printf.printf "(X: %f; Y: %f)" v.x v.y

let apply f v1 v2 =
        { x = (f v1.x v2.x); y = (f  v1.y v2.y) }

let add = apply ( +. )
let sub = apply ( -. )
let mul = apply ( *. )
let div = apply ( /. )

let scalaire v1 v2 =
        let prod = mul v1 v2 in
        prod.x +. prod.y

let length v =
        Float.sqrt(v.x *. v.x +. v.y *. v.y)

let normalize v =
        let len = length v in
        if len = 0.
        then { x = 0.; y = 0. }
        else { x = v.x /. len; y = v.y /. len }

