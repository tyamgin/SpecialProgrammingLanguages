/*****************************************************************************

                        Copyright (c) 2014 Tyamgin

******************************************************************************/

implement treeWindow
    inherits formWindow
    open core, vpiDomains, vpi

predicates
    parent : (string Parent, string Child) determ(i, i).
    brother : (string A, string B) determ(i, i).
    grandpa : (string Grandpa, string Grandson) determ(i, i).
    uncle : (string Uncle, string Nephew) determ(i, i).
    married : (string A, string B) determ(i, i).
    super_parent : (string SuperParent, string SuperChild) determ(i, i).
    relative : (string A, string B) determ(i, i).

clauses
    % parent
    % TODO

    % brother
    brother(A, B) :-
        parent(Parent, A),
        parent(Parent, B).

    % grandpa
    grandpa(Grandpa, Grandson) :-
        parent(Father, Grandson),
        parent(Grandpa, Father).

    % uncle
    uncle(Uncle, Nephew) :-
        brother(Uncle, Bro),
        parent(Bro, Nephew).

    % married
    % TODO

    % super_parent
    super_parent(A, A).
    super_parent(SuperParent, SuperChild) :-
        parent(SuperParent, Parent),
        super_parent(Parent, SuperChild).
    % TODO: учитывать супругов

    % relative
    relative(A, B) :-
        super_parent(SuperParent, A),
        super_parent(SuperParent, B).



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
    onPaint : drawWindow::paintResponder.
clauses
    onPaint(Source, _Rectangle, _GDI) :-
        Handle = Source:getVpiWindow(),
        E = empty(),
        %B = tree("A", tree("B", E, E), tree("C", E, E)),
        B = tree("1", E, tree("2", E, tree("3", E, tree("4", E, E)))),
        Tree = tree("1", tree("2", B, E), tree("3", tree("^", E, B), B)),
        Size = 20,
        Margin = 20,
        drawTree(Handle, 10, 10, Size, Margin, Tree, _, _).

% This code is maintained automatically, do not update it manually. 08:08:02-3.3.2014
predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setFont(vpi::fontCreateByName("Tahoma", 8)),
        setText("TreeWindow"),
        setRect(rct(50,40,514,278)),
        setDecoration(titlebar([closebutton(),maximizebutton(),minimizebutton()])),
        setBorder(sizeBorder()),
        setState([wsf_ClipSiblings,wsf_ClipChildren]),
        menuSet(noMenu),
        setPaintResponder(onPaint).
% end of automatic code
end implement treeWindow