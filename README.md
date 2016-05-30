# Logic-Puzzle-Solver

Two things we need to worry about when solving:

1. If there are n-1 false for a grid, the remaining one is true. In addition, if one is true, the remaining n-1 are false

2. If a and b is false, and a and c is true, then b and c is false

3. if a and b is true, and a and c is true, then b and c is true 

4. if a can only be (b c d, etc.) and (b c d, etc.) are all false for e, then a is false for e

5. if a can only be (b c d, etc.) and b cannot be (b, c, d, etc.) then a is false for b


Just for fun information, rules 2 and 3 are called "Transposition Rules", 4 is called a "Parallel Cross Elimination", and 5 is called a "Skewed Cross Elimination"
The two cross eliminations are really the same thing, but for all these rules it has to be remembered to go both up and down the grid



Luckily, everything will be an "is a" relationship - no comparisons


Knowledge Representation:

Good website for rules: http://logic-puzzles.org/how-to-solve-a-logic-puzzle.php

For multiple of the same facts, split it (ex: a and b are not c -> (a c nil), (b c nil))

Neither a nor b has/is c -> (a c nil), (b c nil) (a b nil)

a is not b -> (a b nil)

a is b -> (a b t)

a does/is not either b or c -> (a b nil), (a c nil)

the n things are: a b c d...n -> (a b nil) (a c nil) (a d nil) ... (a n nil) (b c nil) (b d nil) ... (b n nil) (c d nil) ... etc.

a is either b or c -> (b c nil) (a (b c) t) Note: (b c nil) can be removed if they are same type (ex: Nick has a dog or cat)

of a and b, one was c and the other was d -> (a b nil) (c d nil) (a (c d)) (b (c d))

a's b-type (ex: Whitehall's infield position) -> (a b nil)

for words that encompass multiple things, break them out -> a is an outfielder -> a is either center or right -> use corresponding rule
                                                         
							 -> a is not an outfielder -> (a center nil) (b right nil)


Other Resources: 
http://www.tutorialspoint.com/lisp/lisp_arrays.htm
http://www.gigamonkeys.com/book/collections.html

Psuedocode:

first, read in all rules and data
