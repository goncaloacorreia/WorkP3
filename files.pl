%teste
%read_lines('input.txt', Lines).
        
read_lines(File, Lines) :-
    see(File),
    read_charlist(Chars), parse_charlist(Chars-[], Lines),
    seen.

read_charlist(L) :-
    get_char(X),
    (
        X == ' ', read_charlist(L), ! ;
        X == end_of_file, L = [], ! ;
        L = [X|R], read_charlist(R), !
    ).


parse_charlist(T-T,[]) :- !.
parse_charlist(X1-X4,[L|Ls]) :-
   parse_line(X1-X2,L),
   parse_eol(X2-X3), !,
   parse_charlist(X3-X4,Ls).

parse_eol([]-[]) :- !.           % no end-of-line at end-of-file
parse_eol(['\r','\n'|R]-R) :- !. % DOS/Windows
parse_eol(['\n','\r'|R]-R) :- !. % Mac (?)
parse_eol(['\r'|R]-R) :- !.      % Mac (?)
parse_eol(['\n'|R]-R).           % UNIX

parse_line([]-[],[]) :- !.       % no end-of-line at end-of-file
parse_line([X|X1]-[X|X1],[]) :- eol_char(X), !.
parse_line([X|X1]-X2,[X|Xs]) :- \+ eol_char(X), parse_line(X1-X2,Xs).

eol_char('\r').
eol_char('\n').