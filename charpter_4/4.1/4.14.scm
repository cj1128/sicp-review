;; Exercise 4.14
;; Eva types in the definition of map, and things work
;; Louis installed the system version of map as a primitive and
;; things go terribly wrong.
;; Explain

;; Define map manually

;(define (map proc list)
;  (if (null? list)
;    '()
;    (cons (proc (car list)) (map proc (cdr list)))))

;; and use
;; (map (lambda (x) (+ x 1)) '(1 2 3))
;; in map, proc is a list represents a procedure, (procedure parameters body env)
;; and our eval can evaluate this
;; but system map can't recognize this representation of 'procedure'
;; e.g., system map expects 'car' to be a system 'procedure'
;; but 'car' actually a pair (primitive . <system procedure>)
;; (map car '((1)))

