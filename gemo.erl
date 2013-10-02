%% @author Angus Macdonald (amacdonald AT aetherworks.com)
%% @doc Utility functions for calculating the areas of objects
%% @version 0.1

-module(geom).
-export([area/2]).

%% @doc Calculates the area of a rectangle based on a provided length and width.
%% Returns the area of the rectangle.

-spec(area(number(),number()) -> number()).

area (L, W) -> L * W.

