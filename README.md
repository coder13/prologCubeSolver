Prolog Rubik's Cube solvers

----

This is a set of code that solves twisty puzzles.

Currently, the only define puzzle is the 2x2.
This solver defines the state of a 2x2 based on a permutation and orientation vector and utilizes the fact that the 8th piece is defined based on the other 7 pieces. This also lets us just define the moves U, F, and R to describe every state of a 2x2. We then define 9 moves, 3 U moves, 3 F moves, and 3 R moves. We then have a doMoves predicate to apply a set of moves as [Move, Direction] to scramble the cube. The solve predicate tries different length solutions until it finds a solved solution.

This 2x2 solver is currently very slow for solutions > 7 moves. 
