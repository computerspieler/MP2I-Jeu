module Vec2 = struct
        include Vec2
end

(* Surchage d'operateurs *)
let ( + ) = Vec2.add
let ( - ) = Vec2.sub
let ( * ) = Vec2.mul
let ( / ) = Vec2.div

