(define (same-parity . a)
  (filter (if (odd? (car a)) odd? even?) a))

(display (same-parity 2 3 4 5 6 7))
(newline)

(display (same-parity 1 2 3 4 5 6 7))
