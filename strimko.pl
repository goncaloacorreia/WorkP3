:- use_module(library(clpfd)).
:- [files].

%definir fill_strimko
fill_strimko(S, [X,Y,Z]) :- nth1(X,S,Lx), nth1(Y,Lx,Cy), Cy=Z.

%partition dividir lista em 2
%length(X,10).

%converter para int!!
read1(Lines) :- read_lines('input.txt', Lines), converter(Lines).

converter(L,R) :- accCp(L,R).
accCp([],[]).
accCp([H|T1],[H1|T2]) :- atom_number(H, H1), accCp(T1,T2).

read2(Lines1) :- read1(Y), converter(Y), read2(Y).
%read1(Lines), append(X, Y, Lines), length(X, 2).

dosomething([], _).
dosomething([H|T], X) :- fill_strimko(X, H), dosomething(T, X).

% [[2, 2, 3], [2, 3, 2], [3, 3, 1]]

/*
dosomething([[2, 2, 3], [2, 3, 2], [3, 3, 1]], [[P11,P12,P13,P14],
[P21,P22,P23,P24],
[P31,P32,P33,P34],
[P41,P42,P43,P44]]).
*/

%input teste
teste :-
go( [[_, _, _, _],
[_, 3, 2, _],
[_, _, 1, _],
[_, _, _, _]] ).

%
diff(L) :- L ins 1..4, all_distinct(L).

%execução
go( [[P11,P12,P13,P14],
[P21,P22,P23,P24],
[P31,P32,P33,P34],
[P41,P42,P43,P44]] ) :-

    %linhas
    diff([P11,P12,P13,P14]),
    diff([P21,P22,P23,P24]),
    diff([P31,P32,P33,P34]),
    diff([P41,P42,P43,P44]),

    %colunas
    diff([P11,P21,P31,P41]),
    diff([P12,P22,P32,P42]),
    diff([P13,P23,P33,P43]),
    diff([P14,P24,P34,P44]),

    %streams
    diff([P11,P22,P33,P44]),
    diff([P21,P12,P13,P24]),
    diff([P31,P42,P43,P34]),
    diff([P41,P32,P23,P14]),

    %labelling
    labeling([],[P11,P12,P13,P14,P21,P22,P23,P24,
    P31,P32,P33,P34,P41,P42,P43,P44]),

    %output
    write(P11), write(' '), write(P12), write(' '),
    write(P13), write(' '), write(P14), nl,
    write(P21), write(' '), write(P22), write(' '),
    write(P23), write(' '), write(P24), nl,
    write(P31), write(' '), write(P32), write(' '),
    write(P33), write(' '), write(P34), nl,
    write(P41), write(' '), write(P42), write(' '),
    write(P43), write(' '), write(P44), nl.