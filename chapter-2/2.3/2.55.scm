;; Exercise 2.55
;; 'item is equal to (quote item)
;; so ''abcd is equal to (quote (quote abcd)) which is equal to '(quote abcd)
;; so (car ''abcd) is equal to (car '(quote abcd))
;; and we get back quote
