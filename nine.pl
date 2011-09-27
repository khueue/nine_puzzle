:- begin_tests(nine_puzzle).

test('check all possible') :-
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

nine(Grid, Word) :-
    Grid = [_L1,_L2,_L3, _L4,L5,_L6, _L7,_L8,_L9],
    read_dictionary,
    word(Word),
    atom_chars(Word, Chars),
    suitable_length(Chars),
    singletons(Chars, Grid),
    lists:member(L5, Chars).

suitable_length(L) :-
    lists:length(L, Len),
    4 =< Len, Len =< 9.

singletons([], _).
singletons([C|Cs], Grid) :-
    extract(Grid, C, Grid1),
    singletons(Cs, Grid1).

extract([X|Xs], X, Xs) :- !.
extract([X|Xs], Y, [X|Xs1]) :-
    extract(Xs, Y, Xs1).

:- dynamic word/1.

read_dictionary :-
    word(_), % Already loaded.
    !.
read_dictionary :-
    see('dict_terms.txt'),
        read(Word),
        read_word(Word),
    seen.

read_word(end_of_file) :- !.
read_word(Term) :-
    assert(Term),
    read(NextTerm),
    read_word(NextTerm).
