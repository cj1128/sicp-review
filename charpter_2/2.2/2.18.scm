;; Exercise 2.18

(define (reverse l)
  (if (= (length l) 1) l
      (append (reverse (cdr l)) (list (car l) ))))

(display (reverse (list 1 2 3 4)))

