-module(stats).
-export([minimum/1, maximum/1, range/1]).

minimum(List) ->
	[First | Remainder] = List,
	minimum(Remainder, First).

minimum(List, SmallestNum) ->
	if
		List =:= [] ->
			SmallestNum;
		hd(List) < SmallestNum ->
			minimum(tl(List), hd(List));
		true ->
			minimum(tl(List), SmallestNum)
	end.

maximum(List) ->
	[First | Remainder] = List,
	maximum(Remainder, First).

maximum(List, LargestNum) ->
	if 
		List =:= [] ->
			LargestNum;
		hd(List) > LargestNum ->
			maximum(tl(List), hd(List));
		true ->
			maximum(tl(List), LargestNum)
	end.

range(List) ->
	Min = minimum(List),
	Max = maximum(List),

	[Min, Max].
