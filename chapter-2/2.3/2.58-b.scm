; 2.58 b
; The problem becomes substantially harder if we allow
; standard algebraic notation, such as (x + 3 * (x + y + 2)), which drops
; unnecessary parenthese and assumes that multiplication is
; done before addition.

(load "sd-basic.scm")

;
; Helpers
;

; check all elements satisfy
; the predication
(define (all? predicate list)
  (if (null? list)
      true
      (if (predicate (car list))
          (all? predicate (cdr list))
          false)))

; return -1 if not found
(define (_indexOf list item index)
  (if (>= index (length list))
      -1
      (if (eq? (list-ref list index) item)
          index
          (_indexOf list item (+ index 1)))))
(define (indexOf list item)
  (_indexOf list item 0))

(define (sliceOffsetLength l offset length)
  (take (drop l offset) length))

; start and end are 0-based index,
; [start, end)
(define (slice list start end)
  (if
    (>= end start)
    (sliceOffsetLength list start (- end start))
    '()))

(define (unwrap-if-one list)
  (if (= (length list) 1)
      (car list)
      list))

;
; Sum
;

; if there is one '+' symbol
; then it must be a sum
(define (sum? x)
  (and
    (pair? x)
    (memq '+ x)))

(define (make-sum a1 a2)
  (cond
    ((=number? a1 0) a2)
    ((=number? a2 0) a1)
    ((and
       (number? a1)
       (number? a2))
     (+ a1 a2))
    (else
      (list a1 '+ a2))))

; find the first '+' symbol
; the left part is the addend
(define (addend x)
  (let ((idx (indexOf x '+)))
    (unwrap-if-one (slice x 0 idx))))

; find the first '+' symbol
; the right part is the augend
(define (augend x)
  (let ((idx (indexOf x '+)))
    (unwrap-if-one
      (slice x (+ idx 1) (length x)))))

;
; Product
;

; if there are no '+'
; then this is a product
(define (product? x)
  (define (is-plus? a) (eq? a '+))
  (let ((symbols (filter is-plus? x)))
    (= (length symbols) 0)))

(define (make-product m1 m2)
  (cond
    ((or (=number? m1 0)
         (=number? m2 0))
     0)
    ((=number? m1 1) m2)
    ((=number? m2 1) m1)
    ((and
       (number? m1)
       (number? m2))
     (* m1 m2))
    (else (list m1 '* m2))))

; find the first '*'
; the left part is the multiplier
(define (multiplier x)
  (let ((idx (indexOf x '*)))
    (unwrap-if-one (slice x 0 idx))))

; find the first '*'
; the right part is the multiplicand
(define (multiplicand x)
  (let ((idx (indexOf x '*)))
    (unwrap-if-one (slice x (+ idx 1) (length x)))))

(display (deriv '(x + 3 * (x + y + 2)) 'x))
(newline)

(display (deriv '(x + 2 * x + 3 * x) 'x))
(newline)

(display (deriv '(x + x * x) 'x))
