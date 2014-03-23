implement ip_helper
clauses
    write(Ip) :-
        console::write(Ip:getDigits()).

    digitAt([Head | Tail], 0, Head).
    digitAt([Head | Tail], Index, Result) :-
        digitAt(Tail, Index - 1, Result).

end implement ip_helper