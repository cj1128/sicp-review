;; Exercise 3.52

(define sum 0)

;; seq: 1 3 6 10 15 21 28 36 45 55 66 78 91 105 120 136 153 171 190 210

;; value of sum
;; after (define seq ...)
;; sum: 1
;; after (define y ...)
;; sum: 1 + 2 + 3
;; after (define z ...)
;; sum: 1 + 2 + 3 + 4
;; after (stream-ref y 7)
;; sum: 136
;; after (display-stream z)
;; 210

;; the response woude differ if we implemented delay without
;; using the optimization provided by memo-proc?
;; the accum proc would execute more times
