# 7 & 8 Meeting Notes
#### List comphrehensions
Left side is the action, right side is the source/assignment. For example:
	[V*2 || V <-L].
Take every element of L, apply to V, return the result on every element.

The equivalent with map:
	lists:map(fun (V) -> V*2 end, L).

For a cartesian product (much harder to do with map):
	[{V, X, V*X} || V <- L, X <- L].

Can also add a guard at the end:
	[V*2 || V <- L, V rem 2 == 1].
Or:
	[{V, X, V*X} || V <- L, X <- L2, X rem 2 == 1].


#### Exact vs Equivalent equality
	1 == 1.0.
	true

	1 =:= 1.0.
	false

Colon-equal makes sure that they are the same type as well as effective value. There is no java style 'same place in memory' concept.

Same for `=/=` and `/=`.

#### Inspect

To see all exported functions:
	erlang:module_info().

To show available options:
	erlang:<tab>

RP:
	rp(erlang:module_info().

These show a lot of reserved operations that you call as functions (every operator has a functional representation).

### M F A

Module, function, arguments to apply (arity). All functions identified by this.

#### Anonymous Map Call

	lists:map(fun foo:bar/1, L).

#### Examples

Pattern matching example:
	[Name || {Name, Sex, Age} <- People, Age > 40, Sex == $M].

Guard example:
	[Name || {Name, Sex, Age} <- People, Age > 40  orelse Sex == $M].

`or` and `orelse` differ in whether they terminate early.

### Constants

	math:pi().

The constant is the function. You could use a macro:

	-define(PEOPLE, [<mylist>]).

	my_func() ->
		?PEOPLE.

The macro version is not typical. If you ever wanted to export it you couldn't. Macros can also take arguments.

### Fold

Like *reduce* in other languages.

A way to create a single value from a list. Opposite of map in many ways.

In `foldl` you start from the left of the list. In `foldr` you work your way through the list, and fold back from the end.

You probably want to use `foldl` unless you absolutely have to.

### Case or If?

`if` is all about checking guards. A lot of cases you see `_` as the match, then a guard. Tbe `if` doesn't require the wildcard.

If you care about the value, case is often better.

Recommendation to stick to case for pattern matching. Guards (and therefore `if`) is about equality.

### Sorting

There is a total ordering on all erlang objects, so you can get a deterministic ordering on things.

### Processes

Processes have mailboxes. External side queues them, internal side brings the next one in in an atomic way.

Values are copied when sent to other processes. Bad idea to try to send over a pointer and not a copy.

n-m mapped processes.

Guaranteed that two messages from the same process will be received in order.

#### Cast / Call

Language that is sometimes used.

A *cast* is thrown out, with no check that it was received. A *call* is where we wait for a return to confirm.

#### Decomposition into Processes

Not always clear how things should be broken up into processes.

You could have 2 player processes in the same, an extra for a dealer, or extra processes for the war or battlefield, or even for the deck. If the deck was the process, you could have checks for sending cards you don't have, or where a player isn't quick enough.


