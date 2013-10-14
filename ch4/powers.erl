%% @author Angus Macdonald (amacdonald AT aetherworks.com)
%% @doc Functions using recursion.
%% @version 0.1

-module(powers).
-export([raise/2]).

%% @doc Raises a number to the given power.
-spec(raise(number(), integer()) -> number()).
raise(_, 0) -> 1;
raise(X, N) when N < 0 -> 1.0 / raise(X, -N);
raise(X, N) when N > 0 -> raise (X, N, 1).

raise(_, 0, Acc) -> Acc;
raise(X, N, Acc) -> raise(X, N-1, X * Acc).