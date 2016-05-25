;Reads file
;filepath = "/home/330542/Documents/11th grade/AI/LogicObjects.txt"
(defun reader (filepath)
(setf input (open filepath :if-does-not-exist nil))
(setf features nil)
  (when input
    (setf features (read input nil))
    (format t "~a~%" features)
    (dotimes (counter (length features))
      (set (nth counter features) (read input nil))
      (print (eval (nth counter features)))))
    (close input))
