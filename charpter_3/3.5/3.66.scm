;; Exercise 3.66
;; Examine the stream(pairs integers integers) and make comments
;; about the order in which the pairs are placed into the stream

;; how many pairs precede the pair(1,100) ?
;; how many pairs precede the pair(99,100) ?
;; how many pairs precede the pair(100,100) ?

;; all 1 based, (x, y)
;; y == x: 2^x - 1
;; y = x + 1: 2^x - 1 + 2^(x-1)
;; otherwise: 2^x - 1 + 2^(x-1) + 2^x * (y - x - 1)

;; so (1, 100): 1 + 1 + 2 * 98 = 198
;; (99, 100): 2^99 - 1 + 2^98 = 9.6073e29, very very big
;; (100, 100): 2^100 -1 = 1.2676e30, very big too
