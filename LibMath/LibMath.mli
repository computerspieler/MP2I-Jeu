module Vec2: sig
	type vec2 = {
		mutable x: int;
		mutable y: int;
	}

	(* Operations avec un vecteur *)
	(* Cree un vecteur *)
	val create: int -> int -> vec2
	(* Copie un vecteur *)
	val copy: vec2 -> vec2
	(* Affiche le contenu d'un vecteur *)
	val print: vec2 -> unit
	(* Calcul la longueur d'un vecteur *)
	val length: vec2 -> int
	(* Calcul la longueur au carré d'un vecteur *)
	val length_squared: vec2 -> int

	(* operations entre vecteurs *)
	(* Renvoie la somme de 2 vecteurs *)
	val add: vec2 -> vec2 -> vec2
	(* Renvoie la difference de 2 vecteurs *)
	val sub: vec2 -> vec2 -> vec2
	(* Renvoie le produit de 2 vecteurs *)
	val mul: vec2 -> vec2 -> vec2
	(* Renvoie l de 2 vecteurs *)
	val div: vec2 -> vec2 -> vec2

	(* operations entre vecteur et constante *)
	(* Renvoie la somme d'1 vecteur et d'une constante *)
	val add_c: vec2 -> int -> vec2
	(* Renvoie la difference d'1 vecteur et d'une constante *)
	val sub_c: vec2 -> int -> vec2
	(* Renvoie le produit d'1 vecteur et d'une constante *)
	val mul_c: vec2 -> int -> vec2
	(* Renvoie le produit d'1 vecteur et d'une constante *)
	val div_c: vec2 -> int -> vec2
	val ceil_div_c: vec2 -> int -> vec2
	
	(* Renvoie le produit scalaire de 2 vecteurs *)
	val scalaire: vec2 -> vec2 -> int

	(* Applique l'algorithme de Bresenham *)
	val bresenham : vec2 -> vec2 -> (vec2 -> 'a option) -> 'a option
end

val to_radian : float -> float
val ceil_div : int -> int -> int
val clamp : int -> int -> int -> int
