;; Exercise 3.79
;; generalize the solve-2nd procedure so that it can be used
;; to solve general second-order differential equations

        ;                 +                       +
        ;                 |                       |
        ;                 |dy0                    |y0
        ;                 |                       |
        ;   ddy      +----v-----+    dy     +-----v----+  y
        ;+-----------> integral +----+------> integral +----+---->
        ;|           +----------+    |      +----------+    |
        ;|                           |                      |
        ;|                      +----v----+                 |
        ;<----------------------+    f    <-----------------+
        ;                       +---------+

(define (solve-2nd f y0 dy0 dt)
  (define y
    (integral
      (delay dy)
      y0
      dt))
  (define dy
    (integral
      (delay ddy)
      dy0
      dt))
  (define ddy
    (stream-map
      f
      dy
      y))
  y)
