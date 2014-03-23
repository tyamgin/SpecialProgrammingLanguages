implement ipv6
facts
    digts : unsigned*.

clauses
    new(Digits) :-
        digts := Digits.

    getLocalhostIp() = ipv6::new([0,0,0,0,0,0,0,1]).

    digitAt(Idx) = Result :-
        ip_helper::digitAt(digts, Idx, Result).

    toString() = Result :-
        digts = [A, B, C, D, E, F, G, H],
        Result = string::format("%x:%x:%x:%x:%x:%x:%x:%x", A, B, C, D, E, F, G, H).

    setIp(Digits) :-
        digts := Digits.

    getDigits() = digts.

end implement ipv6