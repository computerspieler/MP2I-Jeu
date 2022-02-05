(* open LibRender *)
open LibMath

let _ =
        let v1 = Vec2.create 1. 0. in
        let v2 = Vec2.create (-1.) 0. in
        Vec2.print (v1 + v2);
        Printf.printf "\nScalaire : %f\n" (Vec2.scalaire v1 v2);
        flush stdout;
