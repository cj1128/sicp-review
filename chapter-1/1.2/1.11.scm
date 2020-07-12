(define (recursive-f n)
  (cond
    ((< n 3) n)
    (else (+
            (recursive-f (- n 1))
            (* 2 (recursive-f (- n 2)))
            (* 3 (recursive-f (- n 3)))))))

(display (recursive-f 10))
(newline)

; don't run this, it will run forever
;(display (recursive-f 100))

(define (iterative-f n)
  (define (iter i fi f1 f2 f3)
    (if (= i n)
        fi
        (iter
          (+ i 1)
          (+ fi (* 2 f1) (* 3 f2))
          fi f1 f2)))
  (cond
    ((< n 3) n)
    (else (iter 3 4 2 1 0))))

(display (iterative-f 100))
(newline)
