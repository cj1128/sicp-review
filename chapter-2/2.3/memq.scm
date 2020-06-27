;; Implements of memq

(define (memq item list)
  (cond
   ((null? list)
    #f)
   ((eq? item (car list))
    list)
   (else
    (memq item (cdr list)))
   ))

(display (memq 'd '(a b c d)))
(newline)

(display (memq 'e '(a b c d)))
