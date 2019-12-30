;; data mode `
(print (eq `aaa `bbb))

;; 1.0 is 1
(print (/ 1 2))

;; 1.0/2 and 0.5/1 is not rational number
(print (/ 1.0 2))
(print (/ 0.5 1))

;; cons
(print (cons 1 2))
(print (cons `chicken nil))
(print (cons `chicken `(pork beaf)))
(print (cons `chicken (cons `pork ())))

;; car/cdr
(print (car `(chicken pork beaf)))
(print (cdr `(chicken pork beaf)))
(print (cadr `(chicken pork beaf)))
(print (caddr `(chicken pork beaf)))

;; list
(print (list 1 `(2.1 2.2) 3))
