(load "./huffman-tree.scm")

(define pairs '((A 2) (GET 2) (SHA 3) (WAH 1) (BOOM 1) (JOB 2) (NA 16) (YIP 9)))
(define tree (generate-huffman-tree pairs))

(define msg '(get a job sha na na na na na na na na get a job sha na na na na na na na na wah yip yip yip yip yip yip yip yip yip sha boom))

(define bits (encode msg tree))

(display bits)
(newline)

; 84
(display (length bits))

; The encoding requires 84 bits.
; Would need 36 * 3 = 108 bits if we use a fixed-length code
