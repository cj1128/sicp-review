;;Exercise 1.11

;;Recursive
(define (f n)
  (cond
    ((< n 3) n)
    (else (+
      (f (- n 1))
      (* 2 (f (- n 2)))
      (* 3 (f (- n 3)))))))

;;Iterative
;;the rule of the coefficient
;;(f 5)
;;1 2 3   ;;f(4) f(3) f(2)
;;3 5 3   ;;f(3) f(2) f(1)
;;8 9 9   ;;f(2) f(1) f(0)
;;a b c
;;a+b c+2a 3a
(define (g n)
  (g-iter 1 2 3 (- n 1)))

(define (g-iter a b c s)
  (if (= s 2)
    (+ (* 2 a) b)
    (g-iter (+ a b)
      (+ c (* 2 a))
      (* 3 a)
      (- s 1))))

(display (f 10))
;(display (f 100)) ;;this will be very slow, don't run this
(display "\n")
(display (g 100))