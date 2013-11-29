-module(stats).
-export([minimum/1, maximum/1, range/1, mean/1, stdv/1]).

minimum(List) ->
	try minimum(List, hd(List)) of
		Answer -> Answer
	catch
		error:Error -> {error, Error}
	end.

minimum([], Result) -> Result;

minimum([Head|Tail], Result) ->
  case Head < Result of
    true -> minimum(Tail, Head);
    false -> minimum(Tail, Result)
  end.

maximum(List) ->
	try maximum(List, hd(List)) of
		Result -> Result
	catch
		error:Error -> {error, Error}
	end.

maximum([], Largest) -> Largest;

maximum([Head | Remainder], Largest) ->
	case Head > Largest of
		true -> maximum(Remainder, Head);
		false -> maximum(Remainder, Largest)
	end.


range(List) -> [minimum(List), maximum(List)].

mean(List) ->
	Length = length(List),
	try 
		Sum = lists:foldl(fun (X, Sum) -> Sum + X end, 0, List),
		Sum / Length
	catch
		error:Error -> {error, Error}
	end.