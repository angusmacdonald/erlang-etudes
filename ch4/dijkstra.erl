%% @author Angus Macdonald (amacdonald AT aetherworks.com)
%% @doc Functions using recursion.
%% @version 0.1

-module(dijkstra).
-export([gcd/2]).

%% @doc Calculates the greatest common divisor of two
%% integer values.
-spec(gcd(number(), number()) -> number()).
gcd(M, M) -> M;
gcd(M, N) when M > N -> gcd(M-N, N);
gcd(M, N) when M < N -> gcd(M, N-M).