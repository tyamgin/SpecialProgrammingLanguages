class ip_helper
predicates

    write : (ip Ip) determ(i).
    digitAt : (unsigned* List, unsigned Index, unsigned Result) nondeterm(i, i, o).
    list_bitand : (unsigned* A, unsigned* B, unsigned* Result) nondeterm(i, i, o).

end class ip_helper