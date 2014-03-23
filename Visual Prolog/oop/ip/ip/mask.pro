implement mask inherits ipv4
clauses
    new(Digits) :-
        ipv4::new(Digits).

    getNetworkIp(Ip) = Result :-
        ip_helper::list_bitand(Ip:getDigits(), getDigits(), ListResult),
        Result = mask::new(ListResult).

end implement mask