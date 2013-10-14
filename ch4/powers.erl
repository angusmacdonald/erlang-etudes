%% @author Angus Macdonald (amacdonald AT aetherworks.com)
%% @doc Functions using recursion.
%% @version 0.1

-module(powers).
-export([raise/2, nth_root/2]).

%% @doc Raises a number to the given power.
-spec(raise(number(), integer()) -> number()).
raise(_, 0) -> 1;
raise(X, N) when N < 0 -> 1.0 / raise(X, -N);
raise(X, N) when N > 0 -> raise (X, N, 1).

raise(_, 0, Acc) -> Acc;
raise(X, N, Acc) -> raise(X, N-1, X * Acc).

%% @doc Find the nth root of a number.
-spec(nth_root(number(), integer()) -> number()).
nth_root(X, N) -> nth_root(X, N, X / 2.0).

nth_root(X, N, A) ->
	io:format("Guess: ~p~n", [A]),
	F = raise(A, N) - X,
	Fprime = N * raise(A, N-1),
	Next = A - F / Fprime,
	Change = abs(Next - A),

	if
		Change < 1.0e-8 ->
			Next;
		true ->
			nth_root(X, N, Next)
	end.