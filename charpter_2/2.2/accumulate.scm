;; Accumulate definitaion

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial
                      (cdr sequence)))))

(display (accumulate + 0 (list 1 2 3 4 5)))
(newline)

(display (accumulate * 1 (list 1 2 3 4 5)))
(newline)

(display (accumulate cons '() (list 1 2 3 4 5)))

