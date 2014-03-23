implement ip_helper
clauses
    write(Ip) :-
        console::write(Ip:toString()).

    digitAt([Head | _], 0, Head) :- !.
    digitAt([_ | Tail], Index, Result) :-
        digitAt(Tail, Index - 1, Result).

    list_bitand([], [], []).
    list_bitand([Head1 | Tail1], [Head2 | Tail2], [HeadResult | TailResult]) :-
        HeadResult = bit::bitAnd(Head1, Head2),
        list_bitand(Tail1, Tail2, TailResult).

end implement ip_helper