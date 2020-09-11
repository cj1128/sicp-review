(load "interval-arithmetic.scm")


; For addition and subtraction,
; the width of the result interval is the sum of widths of the arguments.
; It's can be easily proved:
;   interval1 is (x1, y1), width1 is (y1 - x1)/2
;   interval2 is (x2, y2), width2 is (y2 - x2)/2
;   sum is (x1+y1, x2+y2), width is (y2 - y1 + x2 - x1)/2, which equals to (width1 + width2)/2
;   difference is (x1-y2, y1-x2), width is (y1 - x1 + y2 - x2), which equals to (width1 + width2)/2
(begin
  (define interval1 (make-interval 1 5))
  (define interval2 (make-interval 2 10))

  (display "interval1 width: ")
  (display (get-width interval1))
  (newline)

  (display "interval2 width: ")
  (display (get-width interval2))
  (newline)

  (display "add width: ")
  (display (get-width (add-interval interval1 interval2)))
  (newline)

  (display "sub width: ")
  (display (get-width (sub-interval interval1 interval2)))
  (newline))

(display "===========")
(newline)

; For multiplication and division, we can see that the width of the result
; is changing even though the widths of the arguments are the same.
(begin
  (define interval1 (make-interval 1 2))
  (define interval2 (make-interval 2 3))
  (define interval3 (make-interval 3 4))

  (display "width of interval1*interval2: ")
  (display (get-width (mul-interval interval1 interval2)))
  (newline)

  (display "width of interval2*interval3: ")
  (display (get-width (mul-interval interval2 interval3)))
  (newline)

  (display "width of interval1/interval2: ")
  (display (get-width (div-interval interval1 interval2)))
  (newline)

  (display "width of interval2/interval3: ")
  (display (get-width (div-interval interval2 interval3)))
  (newline))
