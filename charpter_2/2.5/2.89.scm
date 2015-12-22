;; Exercise 2.89
;; Define procedures that implement the term-lsit representation appropiate for dense polynomials

;; Representation for dense polynomials
;; (1 3 0 4 2)

;; we suppose that adjoin-term always adjoins a higher order item to the item-list
(define (adjoin-term term term-list)
  (define (adjoin-iter l)
    (if (= (order term) (length l))
        (cons (coeff term) l)
        (adjoin-iter (cons 0 l))))
  (if (=zero? (coeff term))
      term-lsit
      (adjoin-iter term-list)))

(define (first-term term-lsit)
  (cons (- (length term-list) 1)
        (car term-list)))
