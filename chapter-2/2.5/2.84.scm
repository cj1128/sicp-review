;; Exercise 2.84
;; Using the raise operation of exercise 2.83, modify the apply-generic procedure so that it coerces its arguments to have the same type by the method of successive raising.

;; types: integer(1) -> rational(2) -> real(3) -> complex(4)

(define all-types '(complex real rational integer))

(define (apply-generic op . args)
  (define (get-level type)
    (length (memq type all-types)))

  (define (get-highest-level types)
    (let
        ((levels (map get-level types)))
      (apply max levels)))

  (define (raise-iter arg)
    (if (< (get-level arg) target-level)
        (raise-iter (raise arg))
        arg))

  (define (raise-args target-level)
    (map raise-iter args))

  (define (are-same-type? types)
    (let
        ((levels (map get-level types)))
      (apply = levels)))

  (let ((types (map type-tag args)))
    (let ((proc (get op types)))
      (if proc
          (apply proc (map contents args))
          (if (and
               (not (null? types))
               (not (are-same-type? types)))
              (let ((highest-level (get-highest-level types)))
                (apply
                 apply-generic
                 (cons op (raise-args highest-level))))
              (error "No method for types" types))))))
