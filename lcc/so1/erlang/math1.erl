-module(math1).
-export([factorial/1,min/1]).

factorial(0)->1;
factorial(N)->N*factorial(N-1).

min([H])->H;
min([H|T])->R=min(T),
            if R<H->R;true->H end.
