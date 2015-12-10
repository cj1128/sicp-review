;; Exercise 2.81

;; a)
;; infinitly recur

;; b)
;; yes, he is right, we should avoid coercion when arguments are in the same type, in can speed up the operation
;; the apply-generic procedure in the textbook works just fine

;; original procedure

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
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (and
               (= (length args) 2)
               (not (eq? (car type-tags) (cadr type-tags))))
              (let ((type1 (car type-tags))
                    (type2 (cadr type-tags))
                    (a1 (car args))
                    (a2 (cadr args)))
                (let ((t1->t2 (get-coercion type1 type2))
                      (t2->t1 (get-coercion type2 type1)))
                  (cond
                   ((t1->t2)
                    (apply-generic op (t1->t2 a1) a2))
                   ((t2->t1)
                    (apply-generic op (t2->t1 a2) a1))
                   (else
                    (error "No method for these types" (list op type-tags))))))
              (error "No method for these types" (list op type-tags)))))))
