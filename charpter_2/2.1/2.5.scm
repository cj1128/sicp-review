;; Exercise 2.5

(define (cons a b)
  (* (expt 2 a) (expt 3 b)))

(define (num-divs n d)
  (define (try guess)
    (if (= (remainder n (expt d guess)) 0)
        (try (+ guess 1))
        (- guess 1)))
  (try 0))

(define (car p)
  (num-divs p 2))

(define (cdr p)
  (num-divs p 3))

(display (cons 10 20))
(newline)
(display (car (cons 10 20)))
(newline)
(display (cdr (cons 10 20)))
