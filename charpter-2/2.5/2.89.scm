;; Exercise 2.89
;; Define procedures that implement the term-lsit representation appropiate for dense polynomials
;; Representation for dense polynomials
;; (1 3 0 4 2) -> x^4 + 3*x^3 + 4*x^1 + 2

;; we suppose that adjoin-term always adjoins a higher order item to the item-list
(define (make-term order coeff)
  (cons order coeff))

(define (adjoin-term term term-list)
  (define (adjoin-iter l)
    (if (= (order term) (length l))
        (cons (coeff term) l)
        (adjoin-iter (cons 0 l))))
  (if (=zero? (coeff term))
      term-lsit
      (adjoin-iter term-list)))

(define (first-term term-list)
  (make-term (- (length term-list) 1)
        (car term-list)))

;;(l1 l2 l3) -> (0 1 2)
(define (get-length-list l)
  (define (iter result n)
    (if (< n (length l))
      (iter (append result (list n))
        (+ n 1))
      result))
  (iter '() 0))

(define (rest-terms term-list)
  (map
    (lambda (n)
      (first-term (sublist term-list n (length term-list))))
    (sublist (get-length-list term-list) 1 (length term-list))
  ))

;(display (get-length-list '(100 200 300 400)))
;(display (first-term '(1 3 0 4 2)))
(display (rest-terms '(1 3 0 4 2)))
