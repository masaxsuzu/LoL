(progn  (print "this")
        (print "is")
        (print "a")
        (print "test"))

(progn  (prin1 "this")
        (prin1 "is")
        (prin1 "a")
        (prin1 "test"))

(defun say-hello ()
    (print "Please type name:")
    (let ((name (read)))
        (print `(Nice to meet you ,name) )))
    
(say-hello)