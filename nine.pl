:- begin_tests(nine_puzzle).

test('all valid words') :-
    AllPossible =
        [alandsk,dalska,damask,danska,drakma,dranka,kandar,kansla,
        kardan,kladsam,klamra,klandra,klarna,kramla,kransa,krasnal,
        manklar,manska,marknad,marskland,nalkas,saknad,sakral,skalad,
        skalar,skalda,skanda,skandal,skarma,skrada,skrala,skralna,
        skrama,skramla,skrana,slakna,slanka,smakar,smakrad,snarka],
    lists:msort(AllPossible, AllPossibleSorted),
    setof(Word, nine([a,m,n, l,k,a, d,s,r], Word), WordsSorted),
    AllPossibleSorted == WordsSorted.

:- end_tests(nine_puzzle).

% Interestingly, reading and dynamically asserting these terms instead
% of consulting them makes the program about twice as fast?
% See earlier revisions for that code.
:- [dict_terms].

nine(Grid, Word) :-
    Grid = [_,_,_, _,Center,_, _,_,_],
    word(Word),
    atom_chars(Word, Chars),
    lists:length(Chars, Len),
    4 =< Len, Len =< 9,
    singletons(Chars, Grid),
    lists:member(Center, Chars).

singletons([], _).
singletons([C|Cs], Grid) :-
    extract(Grid, C, Grid1),
    singletons(Cs, Grid1).

extract([X|Xs], X, Xs) :- !.
extract([X|Xs], Y, [X|Xs1]) :-
    extract(Xs, Y, Xs1).
