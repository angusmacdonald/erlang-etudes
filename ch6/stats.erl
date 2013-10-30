-module(stats).
-export([minimum/1]).

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