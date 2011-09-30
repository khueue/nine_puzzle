% Interestingly, reading and dynamically asserting these terms instead
% of consulting them makes the program (or at least the dictionary
% creation part) about twice as fast? See earlier revisions for that code.
:- [dict_terms].

:- begin_tests(nine1).

test('all valid words', [true(Got == Expected)]) :-
    Grid = [a,m,n, l,k,a, d,s,r],
    AllPossible =
        [alandsk,dalska,damask,danska,drakma,dranka,kandar,kansla,
        kardan,kladsam,klamra,klandra,klarna,kramla,kransa,krasnal,
        manklar,manska,marknad,marskland,nalkas,saknad,sakral,skalad,
        skalar,skalda,skanda,skandal,skarma,skrada,skrala,skralna,
        skrama,skramla,skrana,slakna,slanka,smakar,smakrad,snarka],
    lists:msort(AllPossible, Expected),
    setof(Word, nine1(Grid,Word), Got).

:- end_tests(nine1).

nine1(Grid, Word) :-
    Grid = [_,_,_, _,Center,_, _,_,_],
    word(Word),
    atom_chars(Word, Chars),
    lists:length(Chars, Len),
    4 =< Len, Len =< 9,          % Restricted length.
    singletons(Chars, Grid),     % Each square used at most once.
    lists:member(Center, Chars). % Middle square must be used.

singletons([], _).
singletons([X|Xs], List) :-
    extract(List, X, List1),
    singletons(Xs, List1).

extract([X|Xs], X, Xs) :- !.
extract([X|Xs], Y, [X|Xs1]) :-
    extract(Xs, Y, Xs1).

:- begin_tests(nine2).

test('test XXX') :-
    Word = marskland,
    nine2(Word, [n,l,a, s,k,a, d,r,m]),
    !.

:- end_tests(nine2).

nine2(Word, Grid) :-
    atom_chars(Word, WordChars),
    WordChars = [_,_,_, _,Center,_, _,_,_],
    permutation(WordChars, Grid),
    Grid = [_,_,_, _,Center,_, _,_,_],
    atom_chars(GridAtom, Grid),
    \+ has_subword_from_dict(GridAtom).

has_subword_from_dict(GridAtom) :-
    word(Word),
    atom_contains(GridAtom, Word).

permutation(List, Perm) :-
    permutation(List, [], Perm).

permutation([], Perm, Perm).
permutation([X|Xs], Perm0, Perm) :-
    insert(Perm0, X, Perm1),
    permutation(Xs, Perm1, Perm).

insert(Ys, X, [X|Ys]).
insert([Y|Ys], X, [Y|Ys1]) :-
    insert(Ys, X, Ys1).

atom_contains(Atom, SubAtom) :-
    sub_atom(Atom, _Before, _Len, _After, SubAtom),
    !.
