/*****************************************************************************

                        Copyright ©

******************************************************************************/

implement main
    open core

domains
    tree = tree(integer Value, tree Left, tree Right) ; empty().
constants
    className = "main".
    classVersion = "".
class predicates
    task37_1:() nondeterm anyflow.
    task37_2:() nondeterm anyflow.
    task37_3:() nondeterm anyflow.

    length:(integer* Array, unsigned Length) nondeterm anyflow.
    append:(integer*, integer*, integer* Result) nondeterm anyflow.
    append:(integer**, integer**, integer** Result) nondeterm anyflow.
    replace:(integer* Array, unsigned I, unsigned J, integer* Result) nondeterm anyflow.
    prepend_each:(integer** Array, integer Obj, integer** Result) nondeterm anyflow.
    subsets:(integer* Array, integer** Result) nondeterm anyflow.
    divide_by_sign:(integer* Array, integer* Negative, integer* Positive) nondeterm anyflow.
    insert_between:(integer* To, integer What, integer* Result) nondeterm anyflow.
    is_permutation:(integer* Array, integer* Result) nondeterm anyflow.
    tree_equal:(tree A, tree B) nondeterm anyflow.
    is_sub_tree:(tree Target, tree Source) nondeterm anyflow.

    unique:(integer* Array, integer* Result) nondeterm anyflow.
    count:(integer*, integer, integer) nondeterm anyflow.
    sub_array:(integer* Array, unsigned First, unsigned Last, integer* Result) nondeterm anyflow.

clauses
    classInfo(className, classVersion).

clauses
    % append
    append([], Array, Array).
    append([X | Xs], Ys, [X | Zs]) :-
        append(Xs, Ys, Zs).

    % length
    length([], 0).
    length([_ | Tail], Length) :-
        length(Tail, SubLength),
        Length = 1 + SubLength.

    % prepend_each
    prepend_each([], _, []).
    prepend_each([Head | Tail], Obj, [[Obj | Head] | ResultTail]) :-
        prepend_each(Tail, Obj, ResultTail).

    % subsets
    subsets([], [[]]).
    subsets([Head | Tail], Result) :-
        subsets(Tail, Sub),
        prepend_each(Sub, Head, New),
        append(Sub, New, Result).


    % replace
    replace(Array, I, I, Array) :- !.
    replace(Array, I, J, Result) :-
        I > J, replace(Array, J, I, Result).
    replace(Array, I, J, Result) :-
        I < J,
        % Array = A + [First] + C + [Second] + D
        append(A, [First | B], Array),
        length(A, I),
        append(C, [Second | D], B),
        length(C, J - I - 1),
        append(C, [First | D], S1),
        append(A, [Second | S1], Result).


    % tree_equal
    tree_equal(empty(), empty()) :- !.
    tree_equal(tree(V1, L1, R1), tree(V2, L2, R2)) :-
        V1 = V2,
        tree_equal(L1, L2),
        tree_equal(R1, R2).

    % is_sub_tree
    is_sub_tree(empty(), _).
    is_sub_tree(Target, tree(SourceValue, SourceLeft, SourceRight)) :-
        tree_equal(Target, tree(SourceValue, SourceLeft, SourceRight))
        ; is_sub_tree(Target, SourceLeft)
        ; is_sub_tree(Target, SourceRight).

    % divide_by_sign
    divide_by_sign([], [], []).
    divide_by_sign([0 | Tail], Negative, Positive) :-
        divide_by_sign(Tail, Negative, Positive).
    divide_by_sign([Head | Tail], [Head | Negative], Positive) :-
        Head < 0,
        divide_by_sign(Tail, Negative, Positive).
    divide_by_sign([Head | Tail], Negative, [Head | Positive]) :-
        Head > 0,
        divide_by_sign(Tail, Negative, Positive).

    % insert_between
    insert_between(To, What, Result) :-
        append(Left, Right, To),
        append(Left, [What | Right], Result).

    % is_permutation
    is_permutation([], []).
    is_permutation([Head | Tail], Result) :-
        is_permutation(Tail, SubPermutation),
        insert_between(SubPermutation, Head, Result).

    %count
    count([], _, 0).
    count([H | T], H, Result) :-
        count(T, H, C),
        Result = C + 1,
        !.
    count([H | T], X, C) :-
        count(T, X, C).

    % unique
    unique([], []).
    unique(Array, PrefixResult) :-
        append(Prefix, [Last], Array),
        unique(Prefix, PrefixResult),
        count(PrefixResult, Last, Count),
        Count > 0.
    unique(Array, Result) :-
        append(Prefix, [Last], Array),
        unique(Prefix, PrefixResult),
        count(PrefixResult, Last, 0),
        append(PrefixResult, [Last], Result).

 /*   unique([H | T], Result) :-
        count(T, H, Count),
        Count > 0,
        unique(T, Result).
    unique([H | T], [H | Result]) :-
        count(T, H, Count),
        Count = 0,
        unique(T, Result).*/

    % sub_array
    sub_array(Array, First, Last, Result) :-
        append(Left, Right, Array),
        length(Left, First),
        append(Result, _, Right),
        length(Result, Last - First + 1).


    task10() :-
        stdio::write("\n\nTask 10\n"),
        stdio::write("Создайте предикат, который разделит исходный список из целых чисел на два списка: список положительных чисел и список отрицательных чисел.\n"),
        divide_by_sign([1,2,-4,3,-2,0,17,0,4,-6,0], Neg, Pos), stdio::writef("divide_by_sign([1,2,-4,3,-2,0,17,0,4,-6,0]) = (%; %)\n", Neg, Pos),
        fail.
    task10() :-
        succeed().


    task19() :-
        stdio::write("\n\nTask 19\n"),
        stdio::write("Создайте предикат, осуществляющий перестановку двух элементов списка с заданными номерами.\n"),
        Arg1 = [1,2,3,4,5,6],
        replace(Arg1, 1, 1, Res1), stdio::writef("replace(%, %, %) = %\n", Arg1, 1, 1, Res1),
        replace(Arg1, 1, 4, Res2), stdio::writef("replace(%, %, %) = %\n", Arg1, 1, 4, Res2),
        fail.
    task19() :-
        succeed().



    task28() :-
        stdio::write("\n\nTask 28\n"),
        stdio::write("Создайте предикат, порождающий всевозможные подмножества исходного множества.\n"),
        subsets([], Res3), stdio::writef("subsets([]) = %\n", Res3),
        subsets([1,2,3], Res4), stdio::writef("subsets([1,2,3]) = %\n", Res4),
        fail.
    task28() :-
        succeed().


    task37_1() :-
        E = empty(),
        Tree1 = tree(1, tree(2, E, E), tree(3, E, E)),
        Tree2 = tree(7, tree(1, tree(2, E, E), tree(3, E, E)), empty()),
        stdio::writef("is_sub_tree(%, %) = ", Tree1, Tree2),
        (is_sub_tree(Tree1, Tree2), stdio::write("true\n"),! ; stdio::write("false")).

    task37_2() :-
        stdio::writef("is_sub_tree(empty(), empty()) = "),
        (is_sub_tree(empty(), empty()), stdio::write("true\n"),! ; stdio::write("false")).

    task37_3() :-
        E = empty(),
        Tree1 = tree(1, tree(2, E, E), tree(3, E, E)),
        Tree2 = tree(7, tree(1, tree(2, E, E), tree(3, E, E)), empty()),
        stdio::writef("is_sub_tree(%, %) = ", Tree2, Tree1),
        (is_sub_tree(Tree2, Tree1), stdio::write("true\n"),! ; stdio::write("false")).

    task37() :-
        stdio::write("\n\nTask 37\n"),
        stdio::write("Создайте предикат, проверяющий, является ли одно дерево поддеревом второго.\n\n"),
        task37_1(), stdio::write("\n"),
        task37_2(), stdio::write("\n"),
        task37_3(), stdio::write("\n"),
        !.
    task37() :-
        succeed().

    task18() :-
        stdio::write("\n\nTask 18\n"),
        stdio::write("Создайте предикат, удаляющий в исходном списке все повторные вхождения элементов\n\n"),
        A = [1,2,1,6,9,6,10,2,19],
        unique(A, Result),
        stdio::writef("unique(%) = %\n", A, Result),
        fail.
    task18() :-
        succeed().

    task25() :-
        stdio::write("\n\nTask 25\n"),
        stdio::write(" Создайте предикат, возвращающий по списку и двум числам M и N подсписок исходного списка, состоящий из элементов с номерами от M до N.\n\n"),
        A = [0,1,2,3,4,5,6,7,8,9],
        First = 3,
        Last = 7,
        sub_array(A, First, Last, Result),
        stdio::writef("sub_array(%, %, %) = %\n", A, First, Last, Result),
        fail.
    task25() :-
        succeed().



    task20() :-
        stdio::write("\n\nTask 20\n"),
        stdio::write("Создайте предикат, генерирующий все перестановки элементов списка, указанного в качестве первого аргумента предиката.\n\n"),
        Permutation = [1,2,3,4],
        stdio::writef("Permutations of % are:\n", Permutation),
        is_permutation(Permutation, Result),
        stdio::writef("%\n", Result),
        fail.
    task20() :-
        succeed().

end implement main

goal
    console::init(),
    mainExe::run(main::task37),
    mainExe::run(main::task19),
    mainExe::run(main::task28),
    mainExe::run(main::task10),
    mainExe::run(main::task20),
    mainExe::run(main::task18), % контрольная
    mainExe::run(main::task25). % контрольная
