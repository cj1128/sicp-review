;; Exercise 4.15

;(define (run-forever) (run-forever))
;(define (try p)
;  (if (halts? p p) (run-forever) 'halted))

;; if try `halts` on try, that is to say, (try try) will return a value, (halts try try) will return true
;; but by definition, (try try) -> (if (halts try try) (run-forever) 'halted)
;; (try try) -> (run-forever) will run forever
;; so, this is a contradiction

;; if try `doesn't halt` on try, that is to say (try try) will run forever, and (halts? try try) will return false
;; but  by definition, (try try) -> (if (halts try try) (run-forever) 'halted)
;; (try try) -> 'halted will return a value
;; so, this is a contradiction too

