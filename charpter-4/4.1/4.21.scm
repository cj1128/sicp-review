;; Exercise 4.21

;; ((lambda (n)
;;    ((lambda (fact) (fact fact n))
;;     (lambda (ft k) (if (= k 1) 1 (* k (ft ft (- k 1))))))))

;; a
;; this is for computing Fibonacci numbers
(display ((lambda (n)
            ((lambda (fact) (fact fact n))
             (lambda (ft k) (if (< k 2) k (+ (ft ft (- k 1)) (ft ft (- k 2))))))) 20))

;; b
(define (f x)
  ((lambda (even? odd?) (even? even? odd? x))
   (lambda (ev? od? n)
     (if (= n 0) true (od? ev? od? (- n 1))))
   (lambda (ev? od? n)
     (if (= n 0) false (ev? ev? od? (- n 1))))))
