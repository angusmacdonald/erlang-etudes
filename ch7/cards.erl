-module(cards).
-export([make_deck/0, show_deck/0, shuffle/1]).

make_deck() ->
	Suites = ["Clubs", "Diamonds", "Hearts", "Spades"],
	Nums = ["A", "K", "Q", "J" , "10", "9", "8", "7", "6", "5", "4", "3", "2"],

	[{Num, Suite} || Num <- Nums, Suite <- Suites].

show_deck() ->
  lists:foreach(fun(Item) -> io:format("~p~n", [Item]) end, make_deck()).

shuffle(List) -> shuffle(List, []).
shuffle([], Acc) -> Acc;

%% Split the list at a random point into Leading (the start of the list)
%% an entry in the middle of the list, and the remainder.
%% Add the middle entry to the accumulator and re-call the function
%% with the remainder of the list (which is concatenated).
shuffle(List, Acc) ->
  {Leading, [H | T]} = lists:split(random:uniform(length(List)) - 1, List),
  shuffle(Leading ++ T, [H | Acc]).