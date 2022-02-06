open Image

(* Renvoie une version de l'image auquel on a appliqué
	un certain angle, avec le centre de l'image comme
	centre de rotation.
	L'angle doit être en Radian *)
val getRotatedImage: image -> float -> image

(* Renvoie une liste de la même images aux angles indiqué 
	Si une liste vide est donnée en argument, une liste vide
	est renvoyé. *)
val getRotatedImages: image -> float list -> image list