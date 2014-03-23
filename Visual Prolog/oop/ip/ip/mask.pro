implement mask inherits ipv4
clauses
    new(Digits) :-
        ipv4::new(Digits).

    getNetworkIp(Ip) = Result :-
        Result = ipv4::getLocalhostIp().

end implement mask