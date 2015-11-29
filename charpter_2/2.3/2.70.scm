;; Exercise 2.70
;; Use generate-huffman-tree to generate a huffman tree and use encode to encode the following message

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
         (else (error "Symbol isn't in tree: " symbol))))))

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge set)
  (cond
   ((= (length set) 1) (car set))
   ((> (length set) 1)
    (successive-merge
     (cons
      (make-code-tree (car set)
                      (cadr set))
      (cddr set))))
   (else (error "Can't call successive-merge with empty set!"))))
(define pairs '((A 2) (GET 2) (SHA 3) (WAH 1) (BOOM 1) (JOB 2) (NA 16) (YIP 9)))

(define tree (generate-huffman-tree pairs))
(define m '(get a job sha na na na na na na na na get a job sha na na na na na na na na wah yip yip yip yip yip yip yip yip yip sha boom))

(define bits (encode m tree))
(display bits)
(newline)

(display (length bits))

;; Require 87 bits to encode this song
;; Would need 36 * 3 = 108 bits if we use fixed-length code
