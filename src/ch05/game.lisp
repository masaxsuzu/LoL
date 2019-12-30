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
(print (look))
(print (walk 'west))
(print (pickup 'chain))
(print (inventory))