type vec2 = {
	mutable x: float;
	mutable y: float;
}

(* Operations avec un vecteur *)
(* Cree un vecteur *)
val create: float -> float -> vec2
(* Affiche le contenu d'un vecteur *)
val print: vec2 -> unit
(* Calcul la longueur d'un vecteur *)
val length: vec2 -> float
(* Renvoie le vecteur normalise
   Renvoie un vecteur nul si la norme du vecteur est nul *)
val normalize: vec2 -> vec2

(* operations entre vecteurs *)
(* Renvoie la somme de 2 vecteurs *)
val add: vec2 -> vec2 -> vec2
(* Renvoie la difference de 2 vecteurs *)
val sub: vec2 -> vec2 -> vec2
(* Renvoie le produit de 2 vecteurs *)
val mul: vec2 -> vec2 -> vec2
(* Renvoie l de 2 vecteurs *)
val div: vec2 -> vec2 -> vec2

(* Renvoie le produit scalaire de 2 vecteurs *)
val scalaire: vec2 -> vec2 -> float