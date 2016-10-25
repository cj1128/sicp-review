;; Exercise 4.13
;; Implements for the evaluator a special form make-unbound!
;; that removes the binding of a given symbol
;; we should only remove the binding in the first frame
;; otherwise, it would be too dangerous to use, removing all
;; the bindings in the environment is usually not we want

(define (make-unbound? exp)
  (tagged-list exp 'make-unbound!))
(define (eval exp env)
  ....
  ((make-unbound? exp)
   (remove-binding! (cadr exp) (first-frame env))))

(define (remove-binding-in-frame! var frame)
  (let ((vars (frame-variables frame)) (vals (frame-values frame)))
    (define (scan pre-vars pre-vals vars vals)
      (if (not (null? vars))
          (if (eq? var (car vars))
              (begin
                (set-cdr! pre-vars (cdr vars))
                (set-cdr! pre-vals (cdr vals)))
              (scan vars vals (cdr vars) (cdr vals)))))
    (if (not (null? vars))
        (if (eq? var (car vars))
            (begin
              (set-car! frame (cdr vars))
              (set-cdr! frame (cdr vals)))
            (scan vars vals (cdr vars) (cdr vals))))))
