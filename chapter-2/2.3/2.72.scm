; 1. What is the order of growth in the number of steps needed to encode a symbol?
; Search the symbol list at each node: O(n) time
; Then take log_n branches (average case)
; Total: O(n * log_n)

; Consider the relative frequencies of the n symbols are like what described in exercise 2.71.

; Give the order of growth of the number of steps need to encode the most frequent and least frequent symbols in the alphabet.

; 2. For the most frequent symbol
; Search through symbol list: O(n) time
; Take the first single branch, since it will be at the top of the list: constant
; Total: O(n)

; 3. For the least frequent symbol: T(n) = O(n^2)
; Search through symbol list at each level: O(n) time
; Take the next branch, since we are only removing one node, it would be: O(n - 1)
; Total: O(n * (n - 1)) = O(n^2)
