open LibRender
open LibMath
open LibPhysics


class map i_carte i_terrain itilesize = object(self)
	val mutable carte = i_carte
	val xsize = 40
    val ysize = 20
	val mutable carte2 =[|
	[|1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1|];
	[|0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0|];
	[|0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0|];
	[|0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0|];
	[|0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0|];
	[|0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0|];
	[|0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0|];
	[|0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0|];
	[|0;0;0;0;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;0;0;0;0|];
	[|0;0;0;0;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;0;0;0;0|];
	[|0;0;0;0;0;0;0;0;0;1;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0|];
	[|0;0;0;0;0;0;0;0;1;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0|];
	[|0;0;0;0;0;0;0;1;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0|];
	[|0;0;0;0;0;0;1;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0|];
	[|0;0;0;0;0;1;0;0;0;0;0;0;0;1;1;1;1;1;1;1;1;1;0;0;0;1;1;1;1;1;1;1;1;0;0;0;0;0;0;0|];
	[|0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0|];
	[|0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;1;1;1;1;1;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0|];
	[|0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0|];
	[|0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0|];
	[|1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1|];
	|]
    val mutable carte3 =[|
	[|1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1|];
	[|0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0|];
	[|0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0|];
	[|0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0|];
	[|0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0|];
	[|0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0|];
	[|0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0|];
	[|0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0|];
	[|0;0;0;0;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;0;0;0;0|];
	[|0;0;0;0;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;0;0;0;0|];
	[|0;0;0;0;0;0;0;0;0;1;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0|];
	[|0;0;0;0;0;0;0;0;1;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0|];
	[|0;0;0;0;0;0;0;1;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0|];
	[|0;0;0;0;0;0;1;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0|];
	[|0;0;0;0;0;1;0;0;0;0;0;0;0;1;1;1;1;1;1;1;1;1;0;0;0;1;1;1;1;1;1;1;1;0;0;0;0;0;0;0|];
	[|0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0|];
	[|0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;1;1;1;1;1;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0|];
	[|0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0|];
	[|0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0|];
	[|1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1|];
	|]
	val terrains = i_terrain
	val tile_size = itilesize
	val mutable posx = 0

	method fill plane x1 x2 y1 y2 =
    for j = y1 to (if y2 < self#ysize then y2 else self#ysize -1) do 
    for i = x1 to (if x2 < self#xsize then x2 else self#xsize - 1) do
        plane.(j).(i) <- 1
    done; done

    method is_in x y = 
    	if y >= 0 && y < Array.length carte && x >= 0 && x < Array.length carte.(0) then true else false
    	method is_in_3 x y = 
    	if y >= 0 && y < Array.length carte && x >= 0 && x < Array.length carte.(0)*3 then true else false
    method tile_size : int = tile_size
    method xsize : int = Array.length carte.(0) -1
    method ysize : int = Array.length carte - 1

	method is_ground x y =
		match x / xsize with 
			| 0 -> (carte.(y).(x mod xsize) = 1)
			| 1 -> (carte2.(y).(x mod xsize) = 1)
			| _ -> (carte3.(y).(x mod xsize) = 1)

	method getPhysicsTileMap : tilemap =
		{
			size = Vec2.create (Array.length carte.(0)) (Array.length carte);
			tile_size = tile_size;

			collideFunction = self#is_ground;
		}


	method new_chunk = 
        carte <- carte2;
        carte2 <- carte3;
        carte3 <- Array.make_matrix 20 40 0;
        (*let x1 = Random.int self#xsize in 
        let y1 = Random.int self#ysize in 
        let y2 = (Random.int 6) +1 + y1 in 
        let x2 = (Random.int 6) +1 + x1 in *)
        self#fill carte3 0 39 0 0;
        posx <- posx + tile_size*self#xsize;



	method render camerax = 
		let get_ground x y =
			match x / xsize with 
			| 0 -> carte.(y).(x mod xsize)
			| 1 -> carte2.(y).(x mod xsize)
			| _ -> carte3.(y).(x mod xsize) in
		let rec compteur cases acc1 acc2  x y= 
                match cases with 
                | [] -> acc1,acc2 
                | (i,j)::q -> if self#is_in_3 i j then begin 
                                    if i = x || j = y then compteur q ((string_of_int (get_ground i j))::acc1) ((string_of_int (get_ground i j))::acc2) x y
                                        else compteur q ((string_of_int (get_ground i j))::acc1) acc2 x y end  
                                else compteur q ("0"::acc1) ((if i = x || j = y then "0" else "")::acc2) x y
        in 
        (*let prior,minor = compteur [(x+1,y);(x+1,y+1);(x,y+1);(x-1,y+1);(x-1,y);(x-1,y-1);(x,y-1);(x+1,y-1)] [] [] in *)
        for y = 0 to Array.length carte - 1 do 
        	for i = 0 to Array.length carte.(0) do 
        		let a = - (640-camerax+posx) mod tile_size in 
        		let x = (camerax -640 - posx - a)/tile_size + i in
        		if get_ground x y = 0
        		then Image.draw (Hashtbl.find terrains "3")   (i*tile_size-a) (y*tile_size)
            	else 
        			let prior,minor = compteur [(x-1,y);(x-1,y-1);(x,y-1);(x+1,y-1);(x+1,y);(x+1,y+1);(x,y+1);(x-1,y+1)] [] [] x y in
        			let f = String.concat "" prior in let s = String.concat "" ("2"::minor) in
        			if (Hashtbl.mem terrains s) 
            		then Image.draw (Hashtbl.find terrains s) (i*tile_size-a) (	y*tile_size)  
        			else if (Hashtbl.mem terrains f) 
            		then Image.draw (Hashtbl.find terrains f)   (i*tile_size-a) (y*tile_size)
        			else (List.iter (fun s -> print_char s.[0]) prior ; List.iter (fun s -> print_char s.[0]) minor)
        	done;
        done;
        if (self#xsize*tile_size + (640-camerax)+ posx) = 0 then 
            self#new_chunk ;



    	(*for y = 0 to Array.length carte - 1 do 
        for x = 0 to Array.length carte.(y) - 1 do 
            if carte.(y).(x) = 0 then Image.draw (Hashtbl.find terrains "3")   (x*tile_size + (640-camerax)+ posx) ((Array.length carte - 1 - y)*tile_size + (340-cameray))
            else 

        let f = String.concat "" prior in let s = String.concat "" ("2"::minor) in
        if (Hashtbl.mem terrains s) 
            then Image.draw (Hashtbl.find terrains s) (x*tile_size + (640-camerax)+ posx) ((Array.length carte - 1 - y)*tile_size + (340-cameray))  
        else if (Hashtbl.mem terrains f) 
            then Image.draw (Hashtbl.find terrains f)   (x*tile_size + (640-camerax)+ posx) ((Array.length carte - 1 - y)*tile_size + (340-cameray))
        else (List.iter (fun s -> print_char s.[0]) prior ; List.iter (fun s -> print_char s.[0]) minor)
        done; done;

        for y = 0 to Array.length carte2 - 1 do 
        for x = 0 to Array.length carte2.(y) - 1 do 
            if carte2.(y).(x) = 0 then Image.draw (Hashtbl.find terrains "3")   (self#xsize*tile_size + x*tile_size + (640-camerax)+ posx) ((Array.length carte2 - 1 - y)*tile_size + (340-cameray))
            else 
            let rec compteur cases acc1 acc2 = 
                match cases with 
                | [] -> acc1,acc2 
                | (i,j)::q -> if self#is_in i j then begin 
                                    if i = x || j = y then compteur q ((string_of_int carte2.(j).(i))::acc1) ((string_of_int carte2.(j).(i))::acc2)
                                        else compteur q ((string_of_int carte2.(j).(i))::acc1) acc2 end  
                                else compteur q ("0"::acc1) ((if i = x || j = y then "0" else "")::acc2)
        in 
        let prior,minor = compteur [(x+1,y);(x+1,y+1);(x,y+1);(x-1,y+1);(x-1,y);(x-1,y-1);(x,y-1);(x+1,y-1)] [] [] in 
        let f = String.concat "" prior in let s = String.concat "" ("2"::minor) in
        if (Hashtbl.mem terrains s) 
            then Image.draw (Hashtbl.find terrains s) (self#xsize*tile_size + x*tile_size + (640-camerax) + posx) ((Array.length carte2 - 1 - y)*tile_size + (340-cameray))  
        else if (Hashtbl.mem terrains f) 
            then Image.draw (Hashtbl.find terrains f)   (self#xsize*tile_size + x*tile_size + (640-camerax)+ posx) ((Array.length carte2 - 1 - y)*tile_size + (340-cameray))
        else (List.iter (fun s -> print_char s.[0]) prior ; List.iter (fun s -> print_char s.[0]) minor)
        done; done;
        if (self#xsize*tile_size + (640-camerax)+ posx) = 0 then 
            self#new_chunk ;*)

end