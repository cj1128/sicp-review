; pair (i, j) where 1 <= j < i <= n
(define (unique-pairs n)
  (define (flatmap proc seq)
    (fold-right append '() (map proc seq)))

  (define (make-range start end)
    (if (> start end)
        '()
        (cons start
              (make-range (+ start 1) end))))
  (flatmap
    (lambda (i)
      (map (lambda (j)
             (list i j))
           (make-range 1 (- i 1))))
    (make-range 1 n)))

(define (prime? n)
  (define (smallest-divisor n)
    (find-divisor n 2))

  (define (find-divisor n test)
    (cond
      ((> (* test test) n) n)
      ((divide? test n) test)
      (else (find-divisor n (+ 1 test)))))

  (define (divide? test n)
    (= (remainder n test) 0))

  (if (= (smallest-divisor n) n) true false))

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

(define (make-pair-sum pair)
  (list
    (car pair)
    (cadr pair)
    (+ (car pair) (cadr pair))))

(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter
         prime-sum?
         (unique-pairs n))))

(display (prime-sum-pairs 6))
