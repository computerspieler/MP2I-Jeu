module Vec2 = struct
	include Vec2
end

let to_radian deg =
	deg *. Float.pi /. 180.
