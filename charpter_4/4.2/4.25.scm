;; Exercise 4.25

;; (define (unless condition usual-value exceptional-value)
;;   (if condition exceptional-value usual-value))

;; We define unless as shown above and then define factorial in terms of
;; unless as below.

;; (define (factorial n)
;;   (unless (= n 1)
;;           (* n (factorial (- n 1)))
;;           1))

;; What happens if we attempt to evaluate (factorial 5)?
;; Will our definitions work in a normal-order language?

;; Evaluate (factorial 5) will cause infinitely loop because of infinitely
;; evaluating of factorial procedure.

;; It can work in a normal-order language.
