; Ackermann’s function
(define (A x y) (cond ((= y 0) 0)
  ((= x 0) (* 2 y))
  ((= y 1) 2)
  (else (A (- x 1) (A x (- y 1))))))

; (A 1 10)
; -> (A 0 (A 1 9))
; -> (A 0 (A 0 (A 1 8)))
; -> (A 0 (A 0 (A 0 (A 1 7))))
; -> (A 0 (A 0 (A 0 (A 0 (A 1 6)))))
; ...
; 2^10 = 1024
; So, (A 1 x) means 2^x

; (A 2 4)
; -> (A 1 (A 2 3))
; -> (A 1 (A 1 (A 2 2)))
; -> (A 1 (A 1 (A 1 (A 2 1))))
; -> (A 1 (A 1 (A 1 2)))
; ...
; 2^(2^(2^2)) = 2^16 = 65536
; So, (A 2 x) means 2^(2^(2^...)) number of 2 is x

; (A 3 3)
; -> (A 2 (A 3 2))
; -> (A 2 (A 2 (A 3 1)))
; -> (A 2 (A 2 2))
; ...
; -> (A 2 4)
; 2^(2^(2^2)) = 2^16 = 65536

(define (f n) (A 0 n)) ; 2n
(define (g n) (A 1 n)) ; 2^n
(define (h n) (A 2 n)) ; 2^(2^(2^(...))) number of 2 is n
