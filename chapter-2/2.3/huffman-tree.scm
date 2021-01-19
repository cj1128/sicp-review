(load "./huffman-tree-basic.scm")

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

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge set)
  (cond
    ((= (length set) 1) (car set))
    ((> (length set) 1)
     (successive-merge
       (adjoin-set
         (make-code-tree (car set)
                         (cadr set))
         (cddr set))))
    (else (error "empty set SUCCESSIVE-MERGE"))))
