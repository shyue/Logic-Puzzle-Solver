; Daniel Chen
; Josh Yuan


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
(write table)


; fix rules
(setq copy-rules nil)
; for each rule
(dolist (curr-rule rules)
	;single rule
	(if (and (atom (first curr-rule)) (atom (first curr-rule))) 
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
	)
)
(setq rules (reverse copy-rules))





























