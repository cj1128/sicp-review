; Huffman tree implementation

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

; x may be tree of leaf
(define (symbols x)
  (if (leaf? x)
      (list (symbol-leaf x))
      (caddr x)))

; x may be tree of leaf
(define (weight x)
  (if (leaf? x)
      (weight-leaf x)
      (cadddr x)))

(define (decode bits tree)
  (define (_decode bits current-branch)
    (if (null? bits)
        '()
        (let ((next-branch
                (choose-branch (car bits) current-branch)))
          (if (leaf? next-branch)
              (cons (symbol-leaf next-branch)
                    (_decode (cdr bits) tree))
              (_decode (cdr bits) next-branch)))))
  (_decode bits tree))

(define (choose-branch bit current-branch)
  (cond
    ((= bit 0) (left-branch current-branch))
    ((= bit 1) (right-branch current-branch))
    (else (error "bad bit: CHOOSE-BRANCH" bit))))

; set is ordered
(define (adjoin-set x set)
  (cond
    ((null? set) (list x))
    ((< (weight x) (weight (car set)))
     (cons x set))
    (else (cons (car set)
                (adjoin-set x (cdr set))))))

; pairs: a list of symbol-frequency
(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set
          (make-leaf (car pair) (cadr pair))
          (make-leaf-set (cdr pairs))))))
