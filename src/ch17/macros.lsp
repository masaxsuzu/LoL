(defmacro tag (name atts &body body)
    `(progn (print-tag ',name
                        (list ,@(mapcar (lambda (x)
                                            `(cons ',(car x) ,(cdr x)))
                                        (pairs atts)))
                        nil)
            ,@body
            (print-tag ',name nil t)))

(defun print-tag (name alst closingp)
    (princ #\<)
    (when closingp
        (princ #\/))
    (princ (string-downcase name))
    (mapc (lambda (att)
            (format t " ~a=\"~a\"" (string-downcase (car att)) (cdr att)))
        alst)
    (princ #\>))

(defun pairs (lst)
    (labels ((f (lst acc)
                (split lst
                    (if tail
                        (f (cdr tail) (cons (cons head (car tail)) acc))
                        (reverse acc))
                    (reverse acc))))
        (f lst nil)))

(defmacro split (val yes no)
    (let1 g (gensym)
        `(let1 ,g ,val
            (if ,g
                (let ((head (car ,g))
                      (tail (cdr ,g)))
                    ,yes)
                ,no))))
(defmacro let1 (var val &body body)
    `(let ((,var ,val))
        ,@body))

(defmacro svg (width height &body body)
    `(tag svg (xmlns "http://www.w3.org/2000/svg"
               "xmlns:xlink" "http://www.w3.org/1999/xlink" height ,height width ,width)
            ,@body))
(defun brightness (col amt)
    (mapcar (lambda (x)
                (min 255 (max 0 (+ x amt))))
            col))
(defun svg-style (color)
    (format nil "~{fill:rbg(~a,~a,~a);stroke:rgb(~a,~a,~a)~}"
                (append color
                        (brightness color -100))))
(defun circle (center radius color)
    (tag circle (cx (car center)
                 cy (cdr center)
                 r radius
                 style (svg-style color))))
(svg 150 150
    (circle '(50 . 50) 50 '(255 0 0))
    (circle '(100 . 100) 50 '(0 0 255)))

;; (tag mytag (color 'blue height (+ 4 5)))