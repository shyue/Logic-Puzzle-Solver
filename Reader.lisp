;Reads file
;filepath = "/home/330542/Documents/11th grade/AI/LogicObjects.txt"
(defun reader (filepath)
  (setf input (open filepath :if-does-not-exist nil))
  (setf features nil)
  (setf featureLists nil)
  (when input
    (setf features (read input nil))
    (print features)
    (dotimes (counter (length features))
      (setf featureLists (append featureLists (list (read input nil))))))
  (print featureLists)
  (close input))
