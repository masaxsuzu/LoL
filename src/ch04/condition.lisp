(if '()
    (print 'never)
    (print 'nil-is-falsy))

(if '(1)
    (print 'list-is-truthy)
    (print 'never))

(defun my-length (list)
    (if list
        (1+ (my-length (cdr list)))
        0))
(print (my-length '(list with four symbols)))

(print (eq '() nil))
(print (eq '() ()))
(print (eq '() 'nil))

(if (= (+ 1 2) 3)
    (print '1+2=3)
    (print 'never)
    )

(if (= (+ 1 2) 4)
    (print 'never)
    (print '1+2!=4)
    )

(defvar *n-was-odd* nil)

(if (oddp 5)
    (progn (setf *n-was-odd* t)
        (print 'odd))
    (print 'even))
(print *n-was-odd*)

(defvar *n-is-odd* nil)
(when (oddp 5)
 (setf *n-is-odd* t)
 (print 'odd))
(print *n-is-odd*)

(unless (oddp 4)
 (setf *n-is-odd* nil)
 (print 'even))
(print *n-is-odd*)

(defvar *arch-enemy* nil)
(defun pudding-eater1 (person)
    (cond ((eq person 'henry) (setf *arch-enemy* 'stupid-lisp-alien)
                             '(curse you lisp alien - you ate my pudding))
          ((eq person 'johnny) (setf *arch-enemy* 'useless-old-johnny)
                             '(i hope you chocked on my pudding johnny))
          (t                 '(why you eat my pudding stranger ?))))

(print (pudding-eater1 'henry))
(print (pudding-eater1 'johnny))
(print (pudding-eater1 'masa-suzu))

(defun pudding-eater2 (person)
    (case person
        ((henry) (setf *arch-enemy* 'stupid-lisp-alien)
                    '(curse you lisp alien - you ate my pudding))
        ((johnny) (setf *arch-enemy* 'useless-old-johnny)
                    '(i hope you chocked on my pudding johnny))
        (otherwise  '(why you eat my pudding stranger ?))))

(print (pudding-eater2 'henry))
(print (pudding-eater2 'johnny))
(print (pudding-eater2 'masa-suzu))


(print (and (oddp 1) (oddp 3)))
(print (or (oddp 1) (oddp 2)))

(defvar *is-it-even* nil)
(print (or (oddp 4) (setf *is-it-even* t)))
(print *is-it-even*)

(defparameter *fruit* 'apple)

(cond ((eq *fruit* 'apple)  (print 'its-an-apple))
      ((eq *fruit* 'orange) (print 'its-an-orange)))



(print (eq '(a) '(a)))
(print (equal '(a) '(a)))
(print (equal 5 5))
(print (equal 5.0 5.0))
(print (equal "5" "5"))
(print (equal #\5 #\5))

(print (eql 'foo 'foo))
(print (eql 3.4 3.4))
(print (eql #\a #\a))

(print (equal "A" "a"))
(print (equalp "A" "a"))
(print (equalp 3.0 3))
