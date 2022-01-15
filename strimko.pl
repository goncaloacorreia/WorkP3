:- use_module(library(clpfd)).
:- [files].

%ler o ficheiro input.txt
read1(Lines) :- read_lines('input.txt', Lines).

%converter array de strings em ints
converter0(L,R) :- accCp(L,R).
accCp([],[]).
accCp([H|T1],[H1|T2]) :- atom_number(H, H1), accCp(T1,T2).

%converter array de arrays de string em ints
converter(L,R) :- accC(L,R).
accC([],[]).
accC([H|T1],[H1|T2]) :- converter0(H, H1), accC(T1,T2).

%converter o input
converterInput(Y):- read1(L), converter(L, Y).

%preencher o tabuleiro S com os dados do array
fill_strimko(S, [X,Y,Z]) :- nth1(X,S,Lx), nth1(Y,Lx,Cy), Cy=Z.

%aplicar fill_strimko ao tabuleiro a partir de um array de ints
dosomething([], _).
dosomething([H|T], X) :- fill_strimko(X, H), dosomething(T, X).

%aplicar fill_strimko ao tabuleiro partir de input.txt
dosomething1(Z, X) :- converterInput(Z),  dosomething(Z, X).

%ler apenas os valores das posições pré-preenchidas do tabuleiro
readValores(Y) :- converterInput(Lines), append(X, Y, Lines), length(X, 5).

%prencheer o tabuleiro de acordo com o input
dosomething2(Z, X) :- readValores(Z),  dosomething(Z, X).

%execução do strimko
go(Y) :- dosomething2(_, Y), goaux(Y).

%ler apenas os valores das streams do tabuleiro
readSaux(X) :- converterInput(Lines), append(X, _, Lines), length(X, 5).
readStreams(Y) :- readSaux(L), append(_, Y, L), length(Y, 4).

%fazer com que os valores V dentro de cada array sejam diferentes
diff(V) :- V ins 1..4, all_distinct(V).

%execução
goaux( [[P11,P12,P13,P14],
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