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

a is either b or c -> (a x nil) where x is in the same list as b and c, but is not b and c

of a and b, one was c and the other was d -> (a b nil) (c d nil) (a (c d)) (b (c d))

a's b-type (ex: Whitehall's infield position) -> (a b nil)

for words that encompass multiple things, break them out -> a is an outfielder -> a is either center or right -> use corresponding rule
                                                         
							 -> a is not an outfielder -> (a center nil) (b right nil)


Other Resources: 
http://www.tutorialspoint.com/lisp/lisp_arrays.htm
http://www.gigamonkeys.com/book/collections.html

Psuedocode:

first, read in all rules and data

then create table/array - top labels for (a, b, c...n) are a to n-1 from left to right, and side labels are b to n from bottom to top

given that there are y choices for the n features, it will be an (n-1)*y by (n-1)*y array

fix/re-order rules:

1. if it's a singular rule like (x y t) then check which list you find x and y in data. if x is in the same list as y, drop the rule, if y < x switch x and y in rule

2. if it's a multi rule like (x (y z) t) then do the same as singular rule, except look for x and y only, and then swap the first two elements accordingly

while (not fun_solved){

	for each rule:
		
		if it's a singular rule, just insert t or nil in the grid

		if it's a multi rule:

			if it's in the form (a (b c ... ) t) duplicate (b c ... ) look vertically and remove from (b c ...) if [a][...] is false and if the remaining list has only one thing, then [a][remainingOne] = t
 	
			if it's in the form ((b c ...) a t) do the same except look horizontally


	fun_rule1

	vert_rule2and3

	horiz_rule2and3


}


fun_solved -> checks if table is solved:

fun_rule1 -> does rule 1

vert_rule2and3 -> finds all trues, and then looks vertically for a (the same element) and then adds the rules in

horiz_rule2and3 -> finds all trues, and then looks horiz for a (the same element) and then adds the rules in


an additional function called loc will be used

loc will change it into coordinates - choice a can be found in position (feature index-1)*(number of choices per feature)+(position in feature list)
