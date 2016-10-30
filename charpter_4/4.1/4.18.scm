;; Exercise 4.18
;; Consider an alternative strategy for scanning out definitions
;; that translates the example in the text to

(lambda <vars>
  (let ((u '*unassigned*) (v '*unassigned*)
        (let ((a <e1>) (b <e2>))
          (set! u a)
          (set! v b))
        <e3>)))

;; consider the solve procedure from section 3.5.4, will this procedure work
;; if internal definitions are scanned out as shown in this exercise?
;; what if they are scanned out as shown in the text? Explain.

;; (define (solve f y0 dt)
;;   (define y (integral (delay dy) y0 dt))
;;   (define dy (stream-map f y))
;;   y)

;; scanned out as shown in this exercise can't work,
;; because when evaluates a and b, y and dy are both '*unassigned*
;; (define (solve f y0 dt)
;;   (let ((y '*unassigned*) (dy '*unassigned*))
;;     (let ((a (integral (delay dy) y0 dt))
;;           (b (stream-map f y)))
;;       (set! y a)
;;       (set! dy b))
;;     y))

;; scanned out as shown in the text can work.
;; (define (solve f y0 dt)
;;   (let ((y '*unassigned*) (dy '*unassigned*))
;;     (set! y (integral (delay dy) y0 dt))
;;     (set! dy (stream-map f y))
;;     y))


