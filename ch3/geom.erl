%% @author Angus Macdonald (amacdonald AT aetherworks.com)
%% @doc Utility functions for calculating the areas of objects
%% @version 0.2

-module(geom).
-export([area/3]).

-spec(area(atom(), number(),number()) -> number()).

area (rectangle, Length, Width) -> Length * Width;
area (triangle, Base, Height) -> (Base * Height) / 2.0;
area (ellipse, MajorRadius, MinorRadius) -> math:pi() * MajorRadius * MinorRadius.
