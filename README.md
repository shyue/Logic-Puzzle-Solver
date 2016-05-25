# Logic-Puzzle-Solver

Two things we need to worry about when solving:

1. If there are n-1 false for a grid, the remaining one is true. In addition, if one is true, the remaining n-1 are false

2. If a and b is false, and a and c is true, then b and c is false

Luckily, everything will be an "is a" relationship - no comparisons


Knowledge Representation:

Good website for rules: http://logic-puzzles.org/how-to-solve-a-logic-puzzle.php

Neither a nor b has/is c -> (a c nil), (b c nil)
a is not b -> (a b nil)
a is b -> (a b t)
a does/is not either b or c -> (a b nil), (a c nil)
a is either b or c ->



Psuedocode:
