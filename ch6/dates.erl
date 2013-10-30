-module(dates).
-export([date_parts/1, julian/1]).

date_parts(Date) ->
	[Year, Month, Day] = re:split(Date,"-",[{return,list}]),
	[
		element(1, string:to_integer(Year)), 
		element(1, string:to_integer(Month)), 
		element(1, string:to_integer(Day))
	].

julian(Date) ->
 	[Year, Month, Day] = date_parts(Date),
 	DaysPerMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31],
 	julian(Year, Month, Day, DaysPerMonth, 0).

julian(Year, Month, Day, DaysPerMonth, Acc) when Month > (13 - length(DaysPerMonth)) ->
 	NewAcc = Acc + hd(DaysPerMonth),
 	julian(Year, Month, Day, tl(DaysPerMonth), NewAcc).