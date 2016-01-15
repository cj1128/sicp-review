;; Exercise 3.9
;; Use the environment model to analyze two procedures

(define (factorial n)
  (if (= n 1) 1 (* n (factorial (- n 1)))))

(define (factorial n)
  (define (iter product counter)
    (if (> counter n)
        product
        (iter (* counter product)
              (+ counter 1))))
  (iter 1 1))


;; It's hard to express the analysis in text.
;; So I just ignore this exercise.
