;; Exercise 2.90
;; Redesign the polynomial system to support two kinds of term-list representation.

;; This is common code
(define (install-polynomial-term-list)
  (define (the-empty-term-list) '())
  (define (empty-term-list? term-list) (null? term-list))
  (define (make-term order coeff) (cons order coeff))
  (define (order term) (car term))
  (define (coeff term) (cdr term))
)

(define (install-sparse-polynomial-term-list)
  (define (adjoin-term term term-list)
    (if (=zero? (coeff term))
        term-list
        (cons term term-list)))
  (define (first-term term-list) (car term-list))
  (define (rest-terms term-list) (cdr term-list))
  (define (tag p) (attach-tag 'sparse-term-list p))
  (put 'first-term 'sparse-term-list first-term)
  (put 'rest-terms 'sparse-term-list rest-terms)
  (put 'adjoin-term 'sparse-term-list
       (lambda (term term-list)
         (tag (adjoin-term term term-list)))))

(define (install-dense-polynomial-term-list)
  (define (adjoin-term term term-list)
    (define (adjoin-iter l)
      (if (= (order term) (length l))
          (cons (coeff term) l)
          (adjoin-iter (cons 0 l))))
    (if (=zero? (coeff term))
        term-lsit
        (adjoin-iter term-list)))
  (define (first-term term-list)
    (cons (- (length term-list) 1)
          (car term-list)))
  (define (rest-terms term-list)
    (map
      (lambda (n)
        (first-term (sublist term-list n (length term-list))))
      (sublist (get-length-list term-list) 1 (length term-list))
    ))
  (define (tag p) (attach-tag 'dense-term-list p))
  (put 'first-term 'dense-term-list first-term)
  (put 'rest-terms 'dense-term-list rest-terms)
  (put 'adjoin-term 'dense-term-list
       (lambda (term term-list)
         (tag (adjoin-term term term-list)))))

(define (adjoin-term term term-list)
  ((get 'adjoin-term (type term-list)) term term-list))

(define (first-term term-list
  (apply-generic 'first-term term-list)))

(define (rest-terms term-list
  (apply-generic 'rest-terms term-list)))

