open Graphics

class virtual widget _cx _cy _w _h _reactive =
object(self)
	val center_x : int = _cx
	val center_y : int = _cy
	val width : int = _w
	val height : int = _h
	val reactive : bool = _reactive

	val x : int = _cx - _w / 2
	val y : int = _cy - _h / 2

	val mutable mouseOnWidget = false

	method virtual render : unit
	method virtual onClick : unit
	method virtual onMouseEnter : unit
	method virtual onMouseExit : unit

	method isReactive =
		reactive

	method update (ev : Graphics.status) =
		let mouse_on =
			ev.mouse_x >= x && ev.mouse_x <= x + width && 
			ev.mouse_y >= y && ev.mouse_y <= y + height
			in

		if mouse_on && not mouseOnWidget
		then begin
			mouseOnWidget <- true;
			self#onMouseEnter;
		end;

		if not mouse_on && mouseOnWidget
		then begin
			mouseOnWidget <- false;
			self#onMouseExit;
		end;

		if ev.button && mouseOnWidget then self#onClick;

end
