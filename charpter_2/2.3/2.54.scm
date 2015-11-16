;; Exercise 2.54
;; Implements equal?

(define (equal? list1 list2)
  (cond
   ((and
     (null? list1) (null? list2))
    #t)
   ((not
     (= (length list1) (length list2)))
    #f)
   ((not
     (eq? (car list1) (car list2)))
    #f)
   (else
    (equal? (cdr list1) (cdr list2)))))

(display (equal? '(a b c) '(a b c)))
(newline)

(display (equal? '(a b c) '(c d e)))
