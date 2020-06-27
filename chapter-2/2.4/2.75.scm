;; Exercise 2.75
;; Implement make-from-mag-ang in message passing style

(define (make-from-mag-ang mag ang)
  (define (dispatch op)
    (cond
     ((eq? op 'real-part) (* mag (cos ang)))
     ((eq? op 'imag-part) (* mag (sin ang)))
     ((eq? op 'magnitue) mag)
     ((eq? op 'angle) ang)
     (else (error "Unknown op: MAKE-FROM-MAG-ANG" op))))
  dispatch)
