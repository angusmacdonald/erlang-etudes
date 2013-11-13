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
	io:format("End of start~n"). 

create_players() ->
	Player1 = spawn(cards, player, [[self], []]),
	io:format("Spawned player at ~p~n", [Player1]),
	Player2 = spawn(cards, player, [self, []]),
	io:format("Spawned player at ~p~n", [Player2]),
	{Player1, Player2}.

create_dealer() ->
	spawn(cards, dealer, []).




player(Self, Deck) ->
	receive
		{deck, Self, InitialDeck} ->
			io:format("Cards received by ~p~n", [Self]),
			player(Self, InitialDeck);
		{one_card, Dealer} ->
			io:format("Request for one hand received at ~p~n", [Self]),
			[Card | NewDeck] = Deck,
			Dealer ! {one_card, Self, Card},
			player(Self, NewDeck);
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
	Player1 ! {deck, Player1, CardsA},
	Player2 ! {deck, Player2, CardsB},
	io:format("Cards sent to players~n").


make_deck() ->
  [{Value, Suit} || Value <- ["A", 2, 3, 4, 5, 6, 7, 8, 9, 10, "J", "Q", "K"],
    Suit <- ["Clubs", "Diamonds", "Hearts", "Spades"]].

show_deck(Deck) ->
  lists:foreach(fun(Item) -> io:format("~p~n", [Item]) end, Deck).


shuffle(List) -> shuffle(List, []).
shuffle([], Acc) -> Acc;
shuffle(List, Acc) ->
  {Leading, [H | T]} = lists:split(random:uniform(length(List)) - 1, List),
  shuffle(Leading ++ T, [H | Acc]).