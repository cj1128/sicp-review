;; Implements example of "Nesting Mapping"
;; Given a positive integer n,
;; find all ordered pairs of distinct positive integers i and j,
;; where 1 <= j < i <= n, suck that i + j is prime

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

(define (enumerate-interval start end)
  (if (> start end)
      '()
      (cons start
            (enumerate-interval (+ start 1) end))))

(define (flatmap proc seq)
  (fold-right append '() (map proc seq)))

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
        (flatmap
         (lambda (i)
           (map (lambda (j)
                  (list i j))
                (enumerate-interval 1 (- i 1))))
         (enumerate-interval 1 n)))))

(display (prime-sum-pairs 6))
