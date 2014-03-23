/*****************************************************************************

                        Copyright (c) 2014 My Company

******************************************************************************/

implement main
    open core

clauses
    run():-
        console::init(),
        Ip = ipv4::new([192, 168, 1, 3]),
        ip_helper::write(Ip),

        console::write("\n----------------\n"),
        console::writef("We have an ip = %\n", Ip:toString()),
        console::writef("First digit of this ip is % \n", Ip:digitAt(0)),
        console::writef("Class of this Ip is \"%\"\n", Ip:getClass()),
        console::writef("Localhost of IPv4 is %\n", ipv4::getLocalhostIp():toString()),
        console::write("\n"),

        Mask = mask::new([255, 255, 0, 0]),
        console::writef("We have a mask %\n", Mask:toString()),
        console::writef("Network addres is %\n", Mask:getNetworkIp(Ip):toString()),


        console::writef("\n"),
        Ipv6 = ipv6::new([0xfe80, 0, 0, 0, 0x200, 0xf8ff, 0xfe21, 0x67cf]),
        console::writef("We have an Ipv6 = %\n", Ipv6:toString()),
        console::writef("Localhost of IPv6 is %\n", ipv6::getLocalhostIp():toString()),

        fail.
    run():-
        succeed(). % place your own code here
end implement main

goal
    mainExe::run(main::run).