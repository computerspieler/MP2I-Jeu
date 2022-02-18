open Graphics

open GUIWidget

class guiContainer =
	object(_)
		val mutable objects = ([] : widget list)

		method update (ev : status) =
			List.iter (fun e ->
				if e#isReactive then e#update ev;
			) objects

		method render =
			List.iter (fun e -> e#render) objects

		method add (w : widget) =
			objects <- w::objects

	end