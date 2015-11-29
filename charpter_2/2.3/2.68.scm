;; Exercise 2.68
;; write the encode-symbol procedures

(define (make-leaf symbol weight)
  (list 'leaf symbol weight))
(define (leaf? object) (eq? (car object) 'leaf))
(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))
(define (left-branch tree) (car tree))
(define (right-branch tree) (cadr tree))

(define (symbols x)
  (if (leaf? x)
      (list (symbol-leaf x))
      (caddr x)))

(define (weight x)
  (if (leaf? x)
      (weight-leaf x)
      (cadddr x)))

(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
        '()
        (let ((next-branch
               (choose-branch (car bits) current-branch)))
          (if (leaf? next-branch)
              (cons (symbol-leaf next-branch)
                    (decode-1 (cdr bits) tree))
              (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))

(define (choose-branch bit current-branch)
  (cond
   ((= bit 0) (left-branch current-branch))
   ((= bit 1) (right-branch current-branch))
   (else (error "bad bit: CHOOSE-BRANCH" bit))))

(define (adjoin-set x set)
  (cond
   ((null? set) (list x))
   ((< (weight x) (weight (car set)))
    (cons x set))
   (else (cons (car set)
               (adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set
         (make-leaf (car pair) (cadr pair))
         (make-leaf-set (cdr pairs))))))

(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                   (make-leaf 'B 2)
                   (make-code-tree
                    (make-leaf 'D 1)
                    (make-leaf 'C 1)))))

(define sample-bits '(0 1 1 0 0 1 0 1 0 1 1 1 0))
(define sample-message '(A D A B B C A))

(define (encode message tree)
  (if (null? message)
      '()
      (append
       (encode-symbol (car message) tree)
       (encode (cdr message) tree))))

(define (symbol-in-list? symbol l)
  (cond
   ((null? l) #f)
   ((eq? symbol (car l)) #t)
   (else (symbol-in-list? symbol (cdr l)))))

(define (encode-symbol symbol tree)
  (if (leaf? tree)
      '()
      (let
          ((left-symbols (symbols (left-branch tree)))
           (right-symbols (symbols (right-branch tree))))
        (cond
         ((symbol-in-list? symbol left-symbols)
          (cons 0 (encode-symbol symbol (left-branch tree))))
         ((symbol-in-list? symbol right-symbols)
          (cons 1 (encode-symbol symbol (right-branch tree))))
         (else (error "Symbol isn't in tree: " symbol))))))


(display (encode sample-message sample-tree))
