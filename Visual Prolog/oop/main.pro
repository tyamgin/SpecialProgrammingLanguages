/*****************************************************************************

                        Copyright (c) 2014 My Company

******************************************************************************/

implement main
    open core

clauses
    run():-
        console::init(),
        Ip = ipv4::new([192, 168, 1, 3]),
        console::write("\n"),
        console::writef("We have an ip = %\n", Ip:toString()),
        console::writef("First digit of this ip is % \n", Ip:digitAt(0)),
        console::writef("Localhost of IPv4 is %\n", ipv4::getLocalhostIp():toString()),
        console::write("\n"),

        Mask = mask::new([255, 255, 0, 0]),
        console::writef("We have a mask %\n", Mask:toString()),
        ip_helper::write(Mask:getNetworkIp(Ip)), %console::writef("Network addres is %\n", Mask:getNetworkIp(Ip):toString()),
        succeed(). % place your own code here
end implement main

goal
    mainExe::run(main::run).