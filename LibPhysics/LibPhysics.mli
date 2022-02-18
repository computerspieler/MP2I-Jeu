open LibMath

type rect = {
	position : Vec2.vec2;
	dimension : Vec2.vec2;
	velocity : Vec2.vec2;
}

type tilemap = {
	size : Vec2.vec2;
	tile_size : int;

	collideFunction : int -> int -> bool;
}

val computeTilemapRectCollision: tilemap -> rect -> (Vec2.vec2 * Vec2.vec2)
(*val isOnGround: tilemap -> rect -> bool*)