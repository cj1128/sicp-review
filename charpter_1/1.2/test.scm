(define (good-number? n)
    (cond
    ((= n 1) true)
    ((= n 2) false)
    ((= n 10) true)
    (else false)))

(if (good-number? 10) (display "I am a good number!") (display "I am a bda number!"))

