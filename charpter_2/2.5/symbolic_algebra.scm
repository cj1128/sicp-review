(define (install-polynomial-package)
  (define (make-poly var term-list) (cons var term-list))
  (define (variable p) (car p))
  (define (term-list p) (cdr p))

  (define (add-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
        (make-poly (variable p1)
                   (add-terms (term-list p1) (term-list p2)))
        (error "Polys not in same var: ADD-POLY" (list p1 p2))))

  (define (mul-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
        (make-poly
         (variable p1)
         (mul-terms (term-list p1) (term-list p2)))
        (error "Polys not in same var: MUL-POLY" (list p1 p2))))

  (define (add-terms l1 l2)
    (cond
     ((empty-term-list? l1) l2)
     ((empty-term-list? l2) l1)
     (else
      (let
          ((t1 (first-term l1))
           (t2 (first-term l2)))
        (cond
         ((> (order t1) (order t2))
          (adjoin-term
           t1 (add-terms (rest-terms l1) l2)))
         ((> (order t2) (order t1))
          (adjoin-iterm
           t2 (add-terms (rest-terms l2) l1)))
         (else
          (adjoin-term
           (make-term (order t1)
                      (add (coeff t1) (coeff t2)))
           (add-terms (rest-terms l1) (rest-terms l2)))))))))

  (define (mul-terms l1 l2)
    (if (empty-term-list? l1)
        (the-empty-term-list)
        (let ((t1 (first-term l1)))
          (add-terms (mul-term-by-all-terms t1 l2)
                     (mul-terms (rest-terms l1) l2)))))

  (define (mul-term-by-all-terms t l)
    (if (empty-term-list? l)
        (the-empty-term-list)
        (let ((t1 (first-term l)))
          (adjoin-term
           (make-term
            (add (order t) (order t1))
            (mul (coeff t) (coeff t1)))
           (mul-term-by-all-terms t (rest-terms l))))))

  ;; Term List Representation
  (define (adjoin-term term term-list)
    (if (=zero? (coeff term))
        term-list
        (cons term term-list)))
  (define (the-empty-term-list) '())
  (define (first-term term-list) (car term-list))
  (define (rest-terms term-list) (cdr term-list))
  (define (empty-term-list? term-list) (null? term-list))
  (define (make-term order coeff) (cons order coeff))
  (define (order term) (car term))
  (define (coeff term) (cdr term))

  (define (tag p) (attach-tag 'polynomial p))
  (put 'add '(polynomial polynomial)
       (lambda (p1 p2)
         (tag (add-poly p1 p2))))
  (put 'mul '(polynomial polynomial)
       (lambda (p1 p2)
         (tag (mul-poly p1 p2))))
  (put 'make 'polynomial
       (lambda (var term-list)
         (tag (make-poly var term-list))))
  'done
)

