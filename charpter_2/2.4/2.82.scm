;; Exercise 2.82

;; (define (apply-generic op . args)
;;   (let ((type-tags (map type-tag args)))
;;     (let ((proc (get op type-tags)))
;;       (if proc
;;           (apply proc (map contents args))
;;           (if (= (length args) 2)
;;               (let ((type1 (car type-tags))
;;                     (type2 (cadr type-tags))
;;                     (a1 (car args))
;;                     (a2 (cadr args)))
;;                 (let ((t1->t2 (get-coercion type1 type2))
;;                       (t2->t1 (get-coercion type2 type1)))
;;                   (cond
;;                    ((t1->t2)
;;                     (apply-generic op (t1->t2 a1) a2))
;;                    ((t2->t1)
;;                     (apply-generic op (t2->t1 a2) a1))
;;                    (else
;;                     (error "No method for these types" (list op type-tags))))))
;;               (error "No method for these types" (list op type-tags)))))))

(define (apply-generic op . args)
  (define (can-coerced-into? types target-type)
    (andmap
     (lambda (type)
       (or (eq? tyep target-type)
           (get-coercion type target-type)))
     types))
  (define (find-coerced-type types)
    (ormap
     (lambda (target-type)
       (if (can-coerced-into? types target-type)
           target-type
           #f))
     types))
  (define (coerce-all target-type)
    (map
     (lambda (arg)
       (let ((arg-type (type-tag arg)))
         (if (eq? arg-type target-type)
             arg
             ((get-coercion arg-type target-type) arg))))
     args))
  (let ((types (map type-tag args)))
    (let ((proc (get op types)))
      (if proc
          (apply proc (map contents args))
          (let ((target-type (find-coerced-type types)))
            (if target-type
                (apply apply-generic
                       (cons op (coerce-all target-type)))
                (error "No method for these types" (list op types))))))))


(define (ormap procedure list)
  (if (null? list)
      #f
      (let
          ((result (procedure (car list))))
        (if result
            result
            (ormap procedure (cdr list))))))

(define (andmap procedure list)
  (if (null? list)
      #t
      (let
          ((result (procedure (car list))))
        (if (not result)
            result
            (andmap procedure (cdr list))))))



(display (ormap
          (lambda (x)
            (if
             (> x 10)
             x
             #f))
          '(1 3 4 1 2)))
(newline)

(display (andmap
          (lambda (x)
            (if
             (> x 10)
             x
             #f))
          '(1 3 4 1 2)))
