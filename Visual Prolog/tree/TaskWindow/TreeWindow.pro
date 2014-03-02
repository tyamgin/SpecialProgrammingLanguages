/*****************************************************************************

                        Copyright (c) 2014 Tyamgin

******************************************************************************/

implement treeWindow
    inherits formWindow
    open core, vpiDomains, vpi

clauses
    display(Parent) = Form :-
        Form = new(Parent),
        Form:show().

clauses
    new(Parent):-
        formWindow::new(Parent),
        generatedInitialize().


domains
    tree = tree(string Value, tree Left, tree Right) ; empty().

predicates
    drawVertex : (windowHandle Handle, pnt Center, integer Size, string Text) procedure.
clauses
    drawVertex(Handle, pnt(X, Y), Size, Text) :-
        drawRect(Handle, rct(X - Size, Y - Size, X + Size, Y + Size)),
        drawText(Handle, X, Y, Text).

predicates
    drawLines : (windowHandle Handle, pnt Point, pnt* Other) procedure(i,i,i).
clauses
    drawLines(_, _, []).
    drawLines(Handle, Point, [Head | Tail]) :-
        drawLine(Handle, Point, Head),
        drawLines(Handle, Point, Tail).

predicates
    drawTree : (windowHandle Handle, integer StartX, integer StartY, integer Size, integer Margin, tree Tree, pnt* Top, integer EndX) procedure(i,i,i,i,i,i,o,o).
clauses
    drawTree(_, StartX, _, _, _, empty(), [], StartX).
    drawTree(Handle, StartX, StartY, Size, Margin, tree(Value, Left, Right), [Top], EndX) :-
        drawTree(Handle, StartX, StartY + Margin+2*Size, Size, Margin, Left, BottomsLeft, LeftEndX),
        drawTree(Handle, LeftEndX + 2*Size, StartY + Margin+2*Size, Size, Margin, Right, BottomsRight, EndX),
        Top = pnt(LeftEndX + Size, StartY),
        drawVertex(Handle, pnt(LeftEndX + Size, StartY + Size), Size, Value),
        drawLines(Handle, pnt(LeftEndX + Size, 2*Size+StartY), BottomsLeft),
        drawLines(Handle, pnt(LeftEndX + Size, 2*Size+StartY), BottomsRight).


predicates
    onSize : window::sizeListener.
clauses
    onSize(Source) :-
        Handle = Source:getVpiWindow(),
        E = empty(),
        B = tree("A", tree("B", E, E), tree("C", E, E)),
        Tree = tree("1", tree("2", B, E), tree("3", tree("^", E, B), B)),
        Size = 20,
        Margin = 20,
        drawTree(Handle, 10, 10, Size, Margin, Tree, _, _).

% This code is maintained automatically, do not update it manually. 15:28:29-2.3.2014
predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setFont(vpi::fontCreateByName("Tahoma", 8)),
        setText("TreeWindow"),
        setRect(rct(50,40,512,278)),
        setDecoration(titlebar([closebutton(),maximizebutton(),minimizebutton()])),
        setBorder(sizeBorder()),
        setState([wsf_ClipSiblings,wsf_ClipChildren]),
        menuSet(noMenu),
        addSizeListener(onSize).
% end of automatic code
end implement treeWindow