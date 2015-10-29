;; Exercise 2.29

;; First Representation
(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

(define (left-branch m)
  (list-ref m 0))

(define (right-branch m)
  (list-ref m 1))

(define (branch-left b)
  (list-ref b 0))

(define (branch-structure b)
  (list-ref b 1))

;; Second Representation
(define (make-mobile left right)
  (cons left right))
(define (make-branch length structure)
  (cons length structure))
(define (left-branch m)
  (car m))
(define (right-branch m)
  (cdr m))
(define (branch-left b)
  (car b))
(define (branch-structure b)
  (cdr b))

(define (branch-weight b)
  (if (pair? (branch-structure b))
      (total-weight (branch-structure b))
      (branch-structure b)))

(define (total-weight m)
  (+
   (branch-weight (left-branch m))
   (branch-weight (right-branch m))))

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

(define (sub-mobile-balanced? b)
  (if (pair? (branch-structure b))
      (balanced? (branch-structure b))
      #t))

(define (branch-torque b)
  (* (branch-left b)
     (branch-weight b)))

(define (balanced? m)
  (and
   (sub-mobile-balanced? (left-branch m))
   (sub-mobile-balanced? (right-branch m))
   (= (branch-torque (left-branch m))
      (branch-torque (right-branch m)))))

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
