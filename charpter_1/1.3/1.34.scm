;;Exercise 1.34

(define (f g) (g 2))
(f f)

;;(f f) -> (f 2) ->(2 2)
;;Apparently, 2 is not a function, we get a error
