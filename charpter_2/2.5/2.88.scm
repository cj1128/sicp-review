;; Exercise 2.88
;; Extend the polynomial system to include subtraction of polynomials

;; Suppose we have a generic negate operation

(define (install-polynomial-package)
  ;;....
  (define (sub-poly p1 p2)
    (if (same-variable (variable p1) (variable p2))
        (make-poly (variable p1)
                   (add-terms (term-list p1)
                              (negate-term-list (term-list p2))))))

  (define (negate-term-list l)
    (if (empty-term-list? l)
        (the-empty-term-list)
        (let ((term (first-term)))
          (adjoin-term
           (make-term (order term)
                      (negate (coeff term)))
           (negate-term-list (rest-terms l)))))))
