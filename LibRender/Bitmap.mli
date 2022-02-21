open Image

(* Prend un fichier en entree et en deduit le bitmap *)
val readFile: in_channel -> image

(* Meme chose que readFile, sauf qu'il s'occupe
   de fermer le fichier *)
val readFileAndClose: in_channel -> image
