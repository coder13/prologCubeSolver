% permutation: UBL, UBR, UFR, UFL, DBR, DFR, DFL
solved(state([0,1,2,3,4,5,6], [0, 0, 0, 0, 0, 0, 0])).

face(['R'|_], 'R').
face(['U'|_], 'U').
face(['F'|_], 'F').

m(0, _, 0).
m(N, N, 0).
m(B, N, A) :-
  B < N,
  A is B.

m(B, N, A) :-
  B >= N,
  B2 is B - N,
  m(B2, N, A).

move(state([A,B,C,D,E,F,G], [O0,O1,O2,O3,O4,O5,O6]), ['U', 1], state([D,A,B,C,E,F,G], [O3,O0,O1,O2,O4,O5,O6])). % cycle A, B, C, D
move(state([A,B,C,D,E,F,G], [O0,O1,O2,O3,O4,O5,O6]), ['U', 2], state([C,D,A,B,E,F,G], [O2,O3,O0,O1,O4,O5,O6])). % cycle A, B, C, D
move(state([A,B,C,D,E,F,G], [O0,O1,O2,O3,O4,O5,O6]), ['U', -1], state([B,C,D,A,E,F,G], [O1,O2,O3,O0,O4,O5,O6])). % cycle A, B, C, D

move(state([A,B,C,D,E,F,G], [O0,O1,O2,O3,O4,O5,O6]), ['R', 1], state([A,C,F,D,B,E,G], [O0,N2,N5,O3,N1,N4,O6])) :- % cycle C, B, E, F
  m(O1 + 2, 3, N1),
  m(O2 + 1, 3, N2),
  m(O4 + 1, 3, N4),
  m(O5 + 2, 3, N5).

move(state([A,B,C,D,E,F,G], [O0,O1,O2,O3,O4,O5,O6]), ['R', 2], state([A,F,E,D,C,B,G], [O0,O5,O4,O3,O2,O1,O6])). % cycle C, B, E, F
move(state([A,B,C,D,E,F,G], [O0,O1,O2,O3,O4,O5,O6]), ['R', -1], state([A,E,B,D,F,C,G], [O0,N4,N1,O3,N5,N2,O6])) :- % cycle C, B, E, F
  m(O1 + 2, 3, N1),
  m(O2 + 1, 3, N2),
  m(O4 + 1, 3, N4),
  m(O5 + 2, 3, N5).

move(state([A,B,C,D,E,F,G], [O0,O1,O2,O3,O4,O5,O6]), ['F', 1], state([A,B,D,G,E,C,F], [O0,O1,N3,N6,O4,N2,N5])) :- % cycle B, F, G, C
  m(O2 + 1, 3, N2),
  m(O3 + 2, 3, N3),
  m(O5 + 2, 3, N5),
  m(O6 + 1, 3, N6).

move(state([A,B,C,D,E,F,G], [O0,O1,O2,O3,O4,O5,O6]), ['F', 2], state([A,B,G,F,E,D,C], [O0,O1,O6,O5,O4,O3,O2])). % cycle C, B, E, F
move(state([A,B,C,D,E,F,G], [O0,O1,O2,O3,O4,O5,O6]), ['F', -1], state([A,B,F,C,E,G,D], [O0,O1,N5,N2,O4,N6,N3])) :- % cycle B, F, G, C
  m(O2 + 1, 3, N2),
  m(O3 + 2, 3, N3),
  m(O5 + 2, 3, N5),
  m(O6 + 1, 3, N6).

doMoves(S, [], S).

doMoves(S, [Head], NewState) :-
  move(S, Head, NewState).

doMoves(S, [Head, Head2 | Tail], NewState) :-
  move(S, Head, S1),
  face(Head, X),
  face(Head2, Y),
  X \= Y,
  doMoves(S1, [Head2 | Tail], NewState).

num(1).
num(X) :- num(Y), X is Y + 1, X =< 11.

solve(S, Moves) :-
  num(N),
  writeln(N),
  length(Moves, N),
  solved(SolvedState),
  doMoves(S, Moves, SolvedState).
