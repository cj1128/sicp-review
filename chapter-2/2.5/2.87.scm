;; Exercise 2.87
;; Install =zero? for polynomials

;; andmap: and(&&) the items of mapped result, item1 && item2 && item3 && item4 && ...

(define (install-polynomial-package)
  ;;....
  (define (=zero? p)
    (let ((l (term-list p)))
      (if (empty-term-list? l)
          #t
          (andmap (lambda (term)
                    (=zero? (coeff term)))
                  l)))))
