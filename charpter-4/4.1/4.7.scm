;; Exercise 4.7
;; write a procedure let*->nested-lets
;; (let* ((x 3) (y (+ x 2)) (z (+ x y 5))) (* x z))
;;(let ((x 3))
;;  (let ((y (+ x 2)))
;;    (let ((z (+ x y 5)))
      ;;(* x z))))

;; single param, we need to wrap it in list
(define (let*-body exp) (caddr exp))
(define (let*-params exp) (cadr exp))

(define (let*->nested-lets exp)
  (define (make-lets params)
    (if (null? params)
        (let*-body exp)
        (list 'let (list (car params)) (make-lets (cdr params)))))
  (make-lets (let*-params exp)))
