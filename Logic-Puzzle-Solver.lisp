; Daniel Chen
; Josh Yuan



; NOTE: Mispellings may be fatal, as with other minor accidents. Make sure not to mess up!!!

; NOTE: Multi rules (eithers) have not been properly implemented - they may not be necessary for simple puzzles, but possibly for more advanced puzzles

(setq features '(
		(Blacket Bluet Browning Greenfield Whitehall)
		(Four-Leaf-Clover Penny Rabbit-Foot Ribbon Silver-Dollar)
		(Center First Right Shortstop Third)
))

(setq rules '(
		(Browning Center nil)
		(Browning Right nil)
		(Center Penny nil)
		(Center Silver-Dollar nil)
		(Right Penny nil)
		(Right Silver-Dollar nil)
		(Browning Penny nil)
		(Browning Silver-Dollar nil)

		(Bluet Center nil)
		(Bluet Right nil)

		(Greenfield (Center Right) t)
		(Greenfield First nil)
		(Greenfield Shortstop nil)
		(Greenfield Third nil)
		(Whitehall (First Shortstop Third) t)
		(Whitehall Center nil)
		(Whitehall Right nil)
		(Whitehall First nil)
		(Greenfield Four-Leaf-Clover nil)
		(Whitehall Four-Leaf-Clover nil)
		(Greenfield Penny nil)
		(Whitehall Penny nil)
		(Blacket Four-Leaf-Clover nil)
		(Blacket Penny nil)

		(Blacket Ribbon nil)
		(Bluet Ribbon nil)
		(Blacket First nil)
		(Blacket Third nil)
		(Bluet First nil)
		(Bluet Third nil)

		(Center Rabbit-Foot nil)
))


;creating table that is (num features - 1)*(choices for feature) squared
(setf feature-index (- (length features) 1) )
(setf choices (length (car features)) )

(setf table (make-array (list
	(* feature-index choices)
	(* feature-index choices)
)))
;(write table)



; function for checking if puzzle is solved
(defun puzzleSolved ()
	(setq returner t)
	(loop for i from 0 to (- (* choices feature-index) 1) do
		(setq found nil)
		(loop for j from 0 to (- choices 1)  do
			(setq found (or found (and (aref table j i) (not (equalp (aref table j i) 0)))))
		)
		(setq returner (and found returner))
	)


	returner
)

;rule 1 - filling in grid
(defun fillRule ()
	(loop for i from 0 to (- feature-index 1) do
		(loop for j from 0 to (- feature-index (+ 1 i)) do

		;find trues vertically
		(loop for x from 0 to (- choices 1) do
			(setq avail nil)
			(loop for y from 0 to (- choices 1) do
				(if (equalp (aref table (+ (* choices i) x) (+ (* choices j) y)) 0)
					(setq avail (cons y avail))
				)
			)
			(if (and avail (not (cdr avail)))
			(setf (aref table (+ (* choices i) x) (+ (* choices j) (first avail))) t)
			)
		)

		;find trues horizontally
		(loop for y from 0 to (- choices 1) do
			(setq avail nil)
			(loop for x from 0 to (- choices 1) do
				(if (equalp (aref table (+ (* choices i) x) (+ (* choices j) y)) 0)
					(setq avail (cons x avail))
				)
			)
			(if (and avail (not (cdr avail)))
			(setf (aref table (+ (* choices i) (first avail)) (+ (* choices j) y)) t)
			)
		)

		;check for true
			(loop for x from 0 to (- choices 1) do
				(loop for y from 0 to (- choices 1) do
					;(print (list i j x y))
					;(print (aref table (+ (* choices i) x) (+ (* choices j) y)))
					(if (and (aref table (+ (* choices i) x) (+ (* choices j) y)) (not (equalp (aref table (+ (* choices i) x) (+ (* choices j) y)) 0)))
						;(print (list (+ (* choices i) x) (+ (* choices j) y)))
						(loop for a from 0 to (- choices 1) do
							(loop for b from 0 to (- choices 1) do
								;a=x XOR b=y
								(if (and (not (and (equalp a x) (equalp b y))) (or (equalp a x) (equalp b y)))
										(setf (aref table (+ (* choices i) a) (+ (* choices j) b)) nil)
								)
							)
						)
					)
				)
			)
		)
	)
)

;rule 2 and 3
(defun transpositionRule ()


	(loop for i from 0 to (- feature-index 1) do
		(loop for j from 0 to (- choices 1) do
		(loop for a from 0 to (- (* feature-index choices) (+ (* i choices) 1) ) do
			(loop for b from 0 to (- a 1) do


						; vertical
						(if (and (aref table (+ j (* choices i)) a) (aref table (+ j (* choices i)) b)
							(not (equalp (aref table (+ j (* choices i)) a) 0))
							(not (equalp (aref table (+ j (* choices i)) b) 0))
							)
							(setq rules (cons
							(list
							(nth (+ (rem a choices) 0) (nth (+ (floor (/ a choices)) 0) (reverse (cdr features))))
							(nth (+ (rem b choices) 0) (nth (+ (floor (/ b choices)) 0) (reverse (cdr features))))
							 t) rules))
							;(print (list i j a b))
							;(print (nth (+ (floor (/ a choices)) 1) (reverse (cdr features))))

						)


						(if
							(or
								(and (aref table (+ j (* choices i)) a) (not (equalp (aref table (+ j (* choices i)) a) 0)) (equalp (aref table (+ j (* choices i)) b) nil))
								(and (aref table (+ j (* choices i)) b) (not (equalp (aref table (+ j (* choices i)) b) 0)) (equalp (aref table (+ j (* choices i)) a) nil))
							)
								(setq rules (cons
								(list
								(nth (+ (rem a choices) 0) (nth (+ (floor (/ a choices)) 0) (reverse (cdr features))))
								(nth (+ (rem b choices) 0) (nth (+ (floor (/ b choices)) 0) (reverse (cdr features))))
								 nil) rules))
								;(print (list i j a b))
								;(print (nth (+ (floor (/ a choices)) 1) (reverse (cdr features))))
						)

						;horizontal
						(if (and (aref table a (+ j (* choices i))) (aref table b (+ j (* choices i)))
							(not (equalp (aref table a (+ j (* choices i))) 0))
							(not (equalp (aref table b (+ j (* choices i))) 0))
							)
							(setq rules (cons
							(list
							(nth (+ (rem a choices) 0) (nth (+ (floor (/ a choices)) 0) features))
							(nth (+ (rem b choices) 0) (nth (+ (floor (/ b choices)) 0) features))
							 t) rules))
							;(print (list i j a b))
							;(print (nth (+ (floor (/ a choices)) 1) (reverse (cdr features))))

						)


						(if
							(or
								(and (aref table a (+ j (* choices i))) (not (equalp (aref table a (+ j (* choices i))) 0)) (equalp (aref table b (+ j (* choices i))) nil))
								(and (aref table b (+ j (* choices i))) (not (equalp (aref table b (+ j (* choices i))) 0)) (equalp (aref table a (+ j (* choices i))) nil))
							)
								(setq rules (cons
								(list
								(nth (+ (rem a choices) 0) (nth (+ (floor (/ a choices)) 0) features))
								(nth (+ (rem b choices) 0) (nth (+ (floor (/ b choices)) 0) features))
								 nil) rules))
								;(print (list i j a b))
								;(print (nth (+ (floor (/ a choices)) 1) (reverse (cdr features))))
						)







			)
		)
		)
	)
)



; horizontal location - finds array index of the first location in rule (meaning it is on top)
(defun horLoc (a)

(setq returner nil)
(let ((ct 0))
(dolist (curr-feat features)
	(if (numberp (position a curr-feat)) (setq returner (+ (* choices ct) (position a curr-feat))))
	(setq ct (+ ct 1))
))
returner
)

; vertical location - finds array index of the second location in rule (meaning it is on the side)
(defun verLoc (a)
(setq returner nil)
(let ((ct 0))
(dolist (curr-feat (reverse features))
	;(setq curr-feat (reverse curr-feat))
	(if (numberp (position a curr-feat)) (setq returner (+ (* choices ct) (position a curr-feat))))
	(setq ct (+ ct 1))
))
returner
)



; while not solved
(loop while (not (puzzleSolved)) do


; fix rules
(setq copy-rules nil)
; for each rule
(dolist (curr-rule rules)

	;single-single rule
	(if (and (atom (first curr-rule)) (atom (second curr-rule)))
		; check for location of each
		(let ((x 0) (y 0) (ct 0))
		(dolist (curr-feat features)
			(setq ct (+ ct 1))
			(if (numberp (position (first curr-rule) curr-feat)) (setq x ct))
			(if (numberp (position (second curr-rule) curr-feat)) (setq y ct))


		)
		; adding to rules if valid (while also correcting form)
		(if (< x y) (setq copy-rules (cons curr-rule copy-rules)))
		(if (> x y) (setq copy-rules (cons (list (second curr-rule) (first curr-rule) (third curr-rule)) copy-rules)))
		)
		(setq copy-rules (cons curr-rule copy-rules))
	)

	;NOTE: unfinished
	;multi-single rule

	;NOTE: unfinished
	;single-multi rule

	;multi-multi rule
	;none of these, as defined by knowledge representation rules

)

(setq rules (reverse copy-rules))


	(setq copy-rules nil)
	(dolist (curr-rule rules)
		;single-single rule
		(if (and (atom (first curr-rule)) (atom (second curr-rule)))
			(setf (aref table (horLoc (first curr-rule)) (verLoc (second curr-rule))) (third curr-rule))
		)
		(if (not (and (atom (first curr-rule)) (atom (second curr-rule))))
		(setq copy-rules (cons curr-rule copy-rules)))

	)
	(setq rules (reverse copy-rules))
	(print rules)

	(fillRule)



	(transpositionRule)


	(write table)
	(print '-------)

	(return)
)

;(write table)
