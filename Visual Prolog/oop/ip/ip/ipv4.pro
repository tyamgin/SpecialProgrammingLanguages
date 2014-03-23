implement ipv4
open core
facts
    digts : integer*.

clauses
    new(Digits) :-
        digts := Digits.

    getClass() = Result :-
        Result = "A".

    getLocalhostIp() = ipv4::new([127, 0, 0, 1]).

    digitAt(Idx) = Result :-
        %ip_helper::digitAt(digts, Idx, Result), !.
        Result = -1.

    toString() = Result :-
        %digts = [A, B, C, D],
        %Result = string::format("%.%.%.%", A, B, C, D).
        Result = "123".

    setIp(Digits) :-
        digts := Digits.

    getDigits() = digts.

end implement ipv4