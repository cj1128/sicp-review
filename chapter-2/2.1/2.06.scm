; zero = Lf.Lx.x
; one = Lf.Lx.(f x)
; two = Lf.Lx.(f (f x))
; three = Lf.Lx.(f (f (f x)))
; ...

(define zero (lambda (f)
               (lambda (x) x)))

(define one (lambda (f)
              (lambda (x) (f x))))

(define two (lambda (f)
              (lambda (x) (f (f x)))))

; add-1 n = Ln.Lf.Lx.(f ((n f) x))
(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

; add m n = Lm.Ln.Lf.Lx.((m f) ((n f) x))
(define (add m n) (lambda (f)
                   (lambda (x)
                     ((m f) ((n f) x)))))

; We can use this procedure to get real number from church number
(define (inc x) (+ x 1))

(define three (add one two))
(define six (add three three))

; Should be 9
(display (((add three six) inc) 0))

