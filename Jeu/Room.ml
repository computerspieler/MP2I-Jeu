open Graphics

class virtual room =
	object(_)
		method virtual init : unit
		method virtual update : status -> float -> unit
		method virtual render : unit
	end