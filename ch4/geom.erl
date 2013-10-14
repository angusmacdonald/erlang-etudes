%% @author Angus Macdonald (amacdonald AT aetherworks.com)
%% @doc Utility functions for calculating the areas of objects
%% @version 0.3

-module(geom).
-export([area/3]).

-spec(area(atom(), number(),number()) -> number()).

%% @doc Calculates the area of a specified shape (either a 
%% rectangle, a triangle, or an ellipse). Checks that both
%% parameters are greater than or equal to zero.

area (Shape, A, B) when A >=0, B >=0 ->
	case Shape of
		rectangle ->
			A * B;
		triangle ->
			(A * B) / 2.0;
		ellipse ->
			math:pi() * A * B
	end.
