(load "./huffman-tree.scm")

(define (encode message tree)
  (if (null? message)
      '()
      (append
        (encode-symbol (car message) tree)
        (encode (cdr message) tree))))

(define (encode-symbol symbol tree)
  (if (leaf? tree)
      '()
      (let
        ((left-symbols (symbols (left-branch tree)))
         (right-symbols (symbols (right-branch tree))))
        (cond
          ((memq symbol left-symbols)
           (cons 0 (encode-symbol symbol (left-branch tree))))
          ((memq symbol right-symbols)
           (cons 1 (encode-symbol symbol (right-branch tree))))
          (else (error "bad symbol: ENCODE-SYMBOL" symbol))))))

(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                    (make-leaf 'B 2)
                    (make-code-tree
                      (make-leaf 'D 1)
                      (make-leaf 'C 1)))))

(define sample-message '(A D A B B C A))


; expected: '(0 1 1 0 0 1 0 1 0 1 1 1 0))
(display (encode sample-message sample-tree))
(newline)

(display (encode '(A) sample-tree))
(newline)

(display (encode '(A A D) sample-tree))
(newline)

; error
(display (encode '(A A X) sample-tree))
(newline)
