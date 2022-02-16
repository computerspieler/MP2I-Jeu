module Vec2 = struct
	include Vec2
end

let to_radian deg =
	deg *. Float.pi /. 180.

let ceil_div a b =
	(a + b - 1) / b

let clamp i min max =
	assert (min < max);
	     if i < min then min
	else if i > max then max
	else i