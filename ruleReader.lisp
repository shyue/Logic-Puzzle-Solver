;Reads file
;filepath
(defun ruleReader (filepath)
  (setf input (open filepath :if-does-not-exist nil))
  (setf rules nil)
  (when input
    (setf rules (read input nil)))
  (print rules)
  (close input))
