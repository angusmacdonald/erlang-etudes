%% @author Angus Macdonald (amacdonald AT aetherworks.com)
%% @doc Utility functions for calculating the areas of objects
%% @version 0.2

-module(geom).
-export([area/1]).

-spec(area(atom(), number(),number()) -> number()).

%% @doc Calculates the area of a specified shape, given the
%% type of the shape and the two diemsons of the shape.

area ({Shape, A, B}) -> area(Shape, A, B).

%% @doc Calculates the area of a specified shape (either a 
%% rectangle, a triangle, or an ellipse). Checks that both
%% parameters are greater than or equal to zero.

area (rectangle, Length, Width) when Length >=0, Width >=0 
	-> Length * Width;
area (triangle, Base, Height) when Base >=0, Height>=0
	-> (Base * Height) / 2.0;
area (ellipse, MajorRadius, MinorRadius) when MajorRadius>=0, MinorRadius>=0
	-> math:pi() * MajorRadius * MinorRadius;
area (_,_,_)
	-> 0.
