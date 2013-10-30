-module(ask_area).
-export([area/0]).

area() -> 
	ShapeInput = io:get_chars("Enter a shape: [R]ectangle, [T]riangle, [E]llipse:  ", 1),
	 char_to_shape(ShapeInput),
	 get_dimensions("First dimension: ", "Second dimension: ").

char_to_shape(Char) ->
	case Char of
		"R" ->
			rectangle;
		"T" ->
			triangle;
		"E" ->
			ellipse;
		_ ->
			unknown
	end.

get_number(Prompt) ->
	StrInput = io:get_line(Prompt),
	{Test, _} = string:to_float(StrInput),

	case Test of
		error -> {N, _} = string:to_integer(StrInput);
		_ -> N = Test
	end,
	N.


get_dimensions(Prompt1, Prompt2) ->
	Val1 = get_number(Prompt1),
	Val2 = get_number(Prompt2),
	{ Val1, Val2 }.	
