:- begin_tests(nine_puzzle).

test('all valid words', [true(Got == Expected)]) :-
    Grid = [a,m,n, l,k,a, d,s,r],
    AllPossible =
        [alandsk,dalska,damask,danska,drakma,dranka,kandar,kansla,
        kardan,kladsam,klamra,klandra,klarna,kramla,kransa,krasnal,
        manklar,manska,marknad,marskland,nalkas,saknad,sakral,skalad,
        skalar,skalda,skanda,skandal,skarma,skrada,skrala,skralna,
        skrama,skramla,skrana,slakna,slanka,smakar,smakrad,snarka],
    lists:msort(AllPossible, Expected),
    setof(Word, nine(Grid,Word), Got).

:- end_tests(nine_puzzle).

% Interestingly, reading and dynamically asserting these terms instead
% of consulting them makes the program (or at least the dictionary
% creation part) about twice as fast? See earlier revisions for that code.
:- [dict_terms].

nine(Grid, Word) :-
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
