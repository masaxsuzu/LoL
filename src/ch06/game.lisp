(defparameter *nodes* `((living-room (here is your living room.))
                        (garden (here is your garden.))
                        (attic (here is your attic.))))

(defparameter *edges* '((living-room (garden west door)
                                     (attic upstairs ladder))
                        (garden (living-room east door))
                        (attic (living-room downstairs ladder))))

(defparameter *objects* `(whiskey bucket frog chain))

(defparameter *object-locations* '((whiskey living-room)
                                   (bucket living-room)
                                   (chain garden)
                                   (from garden)))
(defparameter *location* 'living-room)

(defun describe-location (location nodes)
    (cadr (assoc location nodes)))

(defun describe-path (edge)
    `(there is a ,(caddr edge) going, (cadr edge) from here.))

(defun describe-paths (location edges)
    (apply #'append (mapcar #'describe-path(cdr (assoc location edges)))))

(defun describe-objects (loc objs obj-loc)
    (labels ((describe-obj (obj)
                `(you see a ,obj on the floor.)))
        (apply #'append (mapcar #'describe-obj (object-at loc objs obj-loc)))))

(defun object-at (loc objs obj-locs)
    (labels ((at-loc-p (obj)
                (eq (cadr (assoc obj obj-locs)) loc)))
        (remove-if-not #'at-loc-p objs)))

(defun look ()
    (append (describe-location *location* *nodes*)
            (describe-paths *location* *edges*)
            (describe-objects *location* *objects* *object-locations*)))

(defun walk (direction)
    (let ((next (find direction
                        (cdr (assoc *location* *edges*))
                        :key #'cadr)))
        (if next
            (progn (setf *location* (car next))
                (look))
            '(you cannot go that way.))))

(defun pickup (object)
    (cond ((member object
                    (object-at *location* *objects* *object-locations*))
            (push (list object 'body) *object-locations*)
            `(you are now carrying the ,object))
            (t '(you cannot get that.))))
(defun inventory ()
    (cons 'items- (object-at 'body *objects* *object-locations*)))

(defun game-repl ()
    (let ((cmd (game-read)))
        (unless (eq (car cmd) 'quit)
            (game-print (game-eval cmd))
            (game-repl))))

(defun game-read ()
    (let ((cmd (read-from-string
                    (concatenate 'string "(" (read-line) ")"))))
        (flet ((quote-it (x)
                    (list 'quote x)))
            (cons (car cmd) (mapcar #'quote-it (cdr cmd))))))

(defparameter *allowed-commands* '(look walk pickup inventory))

(defun game-eval (sexp)
    (if (member (car sexp) *allowed-commands*)
        (eval sexp)
        '(i do not know that command.)))

(defun tweak-text (lst caps lit)
    (when lst
        (let ((item (car lst))
              (rest (cdr lst)))
            (cond ((eql item #\space) (cons item (tweak-text rest caps lit)))
                  ((member item '(#\! #\? #\.)) (cons item (tweak-text rest t lit)))
                  ((eql item #\") (tweak-text rest caps (not lit)))
                  (lit (cons item (tweak-text rest nil lit)))
                  (caps (cons (char-upcase item) (tweak-text rest nil lit)))
                  (t (cons (char-downcase item) (tweak-text rest nil lit)))))))

(defun game-print (lst)
    (princ (coerce (tweak-text (coerce (string-trim "() "
                                       (prin1-to-string lst))
                                'list)
                        t
                        nil)
                'string))
    (fresh-line))

(game-repl)