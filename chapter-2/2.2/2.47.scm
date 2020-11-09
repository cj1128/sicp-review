(define implementation1
  (lambda ()
    (define (make-frame origin edge1 edge2)
      (list origin edge1 edge2))

    (define (origin-frame f)
      (car f))

    (define (edge1-frame f)
      (cadr f))

    (define (edge2-frame f)
      (caddr f))

    (define f1 (make-frame 1 2 3))
    (display (origin-frame f1))
    (newline)

    (display (edge1-frame f1))
    (newline)

    (display (edge2-frame f1))
    (newline)))

(implementation1)
(newline)

(define implementation2
  (lambda ()
    (define (make-frame origin edge1 edge2)
      (cons origin (cons edge1 edge2)))

    (define (origin-frame f)
      (car f))

    (define (edge1-frame f)
      (cadr f))

    (define (edge2-frame f)
      (cddr f))

    (define f2 (make-frame 4 5 6))
    (display (origin-frame f2))
    (newline)

    (display (edge1-frame f2))
    (newline)

    (display (edge2-frame f2))
    (newline)))

(implementation2)
