-module(cards).
-compile(export_all).

start() ->
	Deck = make_deck(),

	io:format("Creating players~n"),
	Players = create_players(),
	io:format("Creating dealer~n"),
	Dealer = create_dealer(),

	io:format("Calling dealer~n"),
	Dealer ! {start, Players, Dealer, Deck},

	receive
		_ ->
			io:format("End!")
		
	end.

create_players() ->
	Player1 = spawn(cards, player, [[]]),
	io:format("Spawned player at ~p~n", [Player1]),
	Player2 = spawn(cards, player, [[]]),
	io:format("Spawned player at ~p~n", [Player2]),
	{Player1, Player2}.

create_dealer() ->
	spawn(cards, dealer, []).




player(Deck) ->
	receive
		{deck, InitialDeck} ->
			io:format("Cards received by ~p~n", [self()]),
			player(InitialDeck);
		{one_card, Dealer} ->
			io:format("Request for one hand received at ~p~n", [self()]),
			[Card | NewDeck] = Deck,
			Dealer ! {one_card, self(), Card},
			player(NewDeck);
		_ -> 
			io:format("Unknown message.")
	end.

dealer() ->
	receive
		{start, {Player1, Player2}, Dealer, Deck} ->
			ShuffledDeck = shuffle(Deck),
			io:format("Shuffled deck~n"),
			SplitDeck =  lists:split(26, ShuffledDeck),
			send_cards(Player1, Player2, SplitDeck),
			send_hand_order(Player1, Player2, Dealer),
			dealer();
		{one_card, Player, Card} ->
			io:format("Recieved card ~p from player ~p~n", [Card, Player])
	end.


send_hand_order(Player1, Player2, Dealer) ->
	Player1 ! {one_card, Dealer}.

send_cards(Player1, Player2, {CardsA, CardsB}) ->
	Player1 ! {deck, CardsA},
	Player2 ! {deck, CardsB},
	io:format("Cards sent to players~n").

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