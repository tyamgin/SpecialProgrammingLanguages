interface ip
predicates
    digitAt : (unsigned Idx) -> unsigned Digit nondeterm(i).
    getDigits : () -> unsigned* Digits.
    setIp : (unsigned* Digits).
    toString : () -> string String determ().

end interface ip