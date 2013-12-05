-module(comp).
-export([comp_example/0, comp_example_two/0]).

people() ->
	[{"Federico", $M, 22}, {"Kim", $F, 45}, {"Hansa", $F, 30}, 
	{"Tran", $M, 47}, {"Cathy", $F, 32}, {"Elias", $M, 50}].


comp_example() ->
	People = people(),
	[Name || {Name, Sex, Age} <- People, Age > 40].

comp_example_two() ->
	People = people(),
	[Name || {Name, Sex, Age} <- People, (Age > 40) orelse (Sex =:= $M)].
