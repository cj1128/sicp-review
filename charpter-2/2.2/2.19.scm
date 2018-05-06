;; Exercise 2.19

(define us-coins
  (list 50 25 10 5 1))

(define us-coins-2
  (list 1 5 10 25 50))

(define uk-coins
  (list 100 50 20 10 5 2 1 0.5))

(define (cc amount coin-values)
  (cond
   ((= amount 0) 1)
   ((or (< amount 0) (no-more? coin-values)) 0)
   (else
    (+
     (cc amount (except-first-denomination coin-values))
     (cc (- amount (first-denomination coin-values)) coin-values)))))

(define (first-denomination values)
  (list-ref values 0))

(define (except-first-denomination values)
  (cdr values))

(define (no-more? values)
  (<= (length values) 0))

;; Apparently , the order doesn't matter
(display (cc 100 us-coins-2))
(display (cc 100 us-coins))
