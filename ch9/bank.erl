-module(bank).
-export([account/1]).

account(Balance) ->
	case get_action() of
		deposit ->
			io:format("Deposit.~n"),
			Amount = get_number("Enter Deposit Amount: $"),
			error_logger:error_report("Logging deposit of ~p", Amount),
			NewBalance = deposit_amount(Balance, Amount),
			account(NewBalance);
		withdrawal ->
			io:format("Withdrawal.~n"),
			Amount = get_number("Enter Withdrawal Amount: $"),
			error_logger:error_report("Logging deposit of ~p
			 from current balance ~p", Amount, Balance),
			NewBalance = withdraw_amount(Balance, Amount),
			account(NewBalance);
		balanceenquiry ->
			io:format("Balance Enquiry.~n");
		quit ->
			io:format("Quit.~n");
		_	->
			io:format("Unknown.~n")
	end.

deposit_amount(Balance, DepositAmount) ->
	case DepositAmount > 10000 of
		true ->
			error_logger:warning_msg("This transaction is on hold.~n");
		false ->
			io:format("Transaction successful."),
			Balance + DepositAmount
	end.

withdraw_amount(Balance, WithdrawAmount) ->
	case WithdrawAmount > Balance of
		true ->
			io:error_msg("Not enough money to complete this transaction.~n");
		false ->
			io:format("Transaction successful."),
			Balance - WithdrawAmount
	end.

get_number(Prompt) ->
  Str = io:get_line(Prompt),
  {Test, _} = string:to_float(Str),
  case Test of
    error -> {N, _} = string:to_integer(Str);
    _ -> N = Test
  end,
  N.

get_action() ->
	Input = io:get_chars("Desired action? 
		[D]eposit, [W]ithdrawal, [B]alance Enquiry, [Q]uit: ", 1),
	char_to_action(Input).

char_to_action(Char) ->
	case Char of
		"D" ->
			deposit;
		"W" ->
			withdrawal;
		"B" ->
			balanceenquiry;
		"Q" ->
			quit;
		_ ->
			unknown
	end.