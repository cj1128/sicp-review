(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

; a.
(define (left-branch m)
  (car m))

(define (right-branch m)
  (list-ref m 1))

(define (branch-length b)
  (car b))

(define (branch-structure b)
  (list-ref b 1))

; Helper function
(define (branch-weight b)
  (let ((s (branch-structure b)))
    (if (number? s)
        s
        (+ (branch-weight (left-branch s)) (branch-weight (right-branch s))))))

; b.
(define (total-weight m)
  (+
    (branch-weight (left-branch m))
    (branch-weight (right-branch m))))

; c.
(define (balanced? m)
  (define (sub-mobile-balanced? b)
    (if (number? (branch-structure b))
        true
        (balanced? (branch-structure b))))
  (define (branch-torque b)
    (* (branch-length b)
       (branch-weight b)))
  (and
    (sub-mobile-balanced? (left-branch m))
    (sub-mobile-balanced? (right-branch m))
    (= (branch-torque (left-branch m))
       (branch-torque (right-branch m)))))

(define (test)
  (define m1 (make-mobile
               (make-branch 10 10)
               (make-branch 5 5)))
  (define m2 (make-mobile
               (make-branch 20 m1)
               (make-branch 10 m1)))
  (define m3 (make-mobile
               (make-branch 1 20)
               (make-branch 2 m2)))

  (display (total-weight m1))
  (newline)

  (display (total-weight m2))
  (newline)

  (display (total-weight m3))
  (newline)

  (define balanced-m1 (make-mobile
                        (make-branch 1 2)
                        (make-branch 2 1)))

  (define balanced-m2 (make-mobile
                        (make-branch 2 10)
                        (make-branch 4 5)))

  (define balanced-m3 (make-mobile
                        (make-branch 5 balanced-m1)
                        (make-branch 1 balanced-m2)))

  (define unbalanced-m4 (make-mobile
                          (make-branch 1 2)
                          (make-branch 2 4)))

  (display (balanced? balanced-m1))
  (newline)

  (display (balanced? balanced-m2))
  (newline)

  (display (balanced? balanced-m3))
  (newline)

  (display (balanced? unbalanced-m4))
)

(test)

; d.
; We only have to change `right-branch` and `branch-structure`
(define (make-mobile left right) (cons left right))
(define (make-branch length structure) (cons length structure))

(define (right-branch m) (cdr m))
(define (branch-structure b) (cdr b))

(newline)
(display "==== New Representation ====")
(newline)

(test)
