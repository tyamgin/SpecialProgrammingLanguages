/*****************************************************************************

                        Copyright (c) 2014 My Company

******************************************************************************/

implement statusLine
    open core, vpiDomains, vpiToolbar, resourceIdentifiers


clauses
    create(Parent):-
        _ = vpiToolbar::create(style, Parent, controlList).

% This code is maintained automatically, do not update it manually. 11:30:30-2.3.2014
constants
    style : vpiToolbar::style = tb_bottom().
    controlList : vpiToolbar::control_list =
        [
        tb_text(idt_help_line,tb_context(),452,0,4,10,0x0,"")
        ].
% end of automatic code
end implement statusLine 