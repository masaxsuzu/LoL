(defparameter *small* 1)
(defparameter *big* 100)

(defun guess-number ()
    (ash (+ *small* *big*) -1))

(defun << ()
    (setf *big* (1- (guess-number)))
    (print (guess-number)))

(defun >> ()
    (setf *small* (1+ (guess-number)))
    (print (guess-number)))
  
(defun start ()
  (defparameter *small* 1)
  (defparameter *big* 100)
  (guess-number))

(defun main (&rest argv)
  (declare (ignorable argv))
  (start)
  (>>)
  (<<)
  (>>)
  (>>)
  (>>)
  (>>)
  (>>))

(main)