# Chapters 5 and 6 : October 30th

## eunit

	include_lib("...eunit.hrl").

	...

	?_assert

Sometimes the tests are in the module, other times not -- remotely exposed module hash can be changed by them, which is bad for distributed code.

	eunit:test(module_name).

Lots of use of higher-level integration tools, also dializer and quick check.

Integrates into Jenkins

## Etude 5

re:split returns a binary string list unless you specify `[{return, list}]`.

`"http://" ++ Rest = "http://www.google.com".`
`[$h , $t, $t, $p | Rest] = "http://www.google.com".`

`[Head1, Head2, Head2, Head3 | Rest] = "http://www.googl.com".`
These do a pattern match, with `www.google.com` assigned to `Rest`.

`string:to_float` accepts a string after a float, which it breaks up into a separate list element if a float can be parsed.

Adding a `++ ".0"` will always make to_float work. Little hack.

### Exception handling

Some used guards / overloaded functions to stop calculate from being called with invalid items
Others used a flow of functions being able to handle errors from above functions and doing nothing further if this happened.

Pattern matching (overloading) seems to be the preferred option.

# Etude 6

Typical solution to dates was to use pattern matching (overloading), rather than if/case/guard.

One person used a lambda, a comparator, which determined whether to use max or min.

`fun erlang:'>'/2.` gets you the operator as a function, which makes for an even simpler lambda.

Case statement can be part of case statement, such as `28 + case XXX of`.

`andalso` and `orelse` syntax.

Look at the end of the etude for the guide to the erlang efficiency guide, which is useful for avoiding pitfalls.

`any/2` function with a lambda.

It's cheaper to have a bigger list on the right than the left. Questions about this though. The first one needs to be copied to create the new head, but it might be able to point to the second one. Optimization.

Arrays implememnted as tuples of tuples of size 10, so if one of those 10 sized tuples has no defined contents, it just stores the number 10 in the root tuple, rather than having a 10 sized tuple containing only `undefined` elements.

You can try this with: `array:set(12, aaa, X).`