implement ipv4
facts
    digts : unsigned*.

clauses
    new(Digits) :-
        digts := Digits.

/*
    Класс A	0	     адрес сети (7 бит)	адрес хоста (24 бита)
    Класс B	10	 адрес сети (14 бит)	адрес хоста (16 бит)
    Класс C	110	 адрес сети (21 бит)	адрес хоста (8 бит)
    Класс D	1110	 Адрес многоадресной рассылки
    Класс E	    1111  Зарезервировано
*/
    getClass() = Result :-
        0 = bit::bitAnd(0x80, digitAt(0)),
        Result = "A",
        !.

    getClass() = Result :-
        0 = bit::bitAnd(0x40, digitAt(0)),
        Result = "B",
        !.

    getClass() = Result :-
        0 = bit::bitAnd(0x20, digitAt(0)),
        Result = "C",
        !.

    getClass() = Result :-
        0 = bit::bitAnd(0x10, digitAt(0)),
        Result = "D",
        !.

    getClass() = "E".





    getLocalhostIp() = ipv4::new([127, 0, 0, 1]).

    digitAt(Idx) = Result :-
        ip_helper::digitAt(digts, Idx, Result).

    toString() = Result :-
        digts = [A, B, C, D],
        Result = string::format("%.%.%.%", A, B, C, D).

    setIp(Digits) :-
        digts := Digits.

    getDigits() = digts.

end implement ipv4