;; Exercise 2.42
;; Eight-Queens puzzle

(define (flatmap proc seq)
  (fold-right append '() (map proc seq)))

(define (enumerate-interval start end)
  (if (> start end)
      '()
      (cons start
            (enumerate-interval (+ start 1) end))))

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (solution)
           (safe? k solution))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position
                    new-row
                    rest-of-queens))
                 (enumerate-interval
                  1
                  board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

(define empty-board '())

(define (adjoin-position new-row rest-of-queens)
  (append rest-of-queens (list new-row)))

(define (safe? k solution)
  (if (or
       (= (length solution) 0)
       (= (length solution) 1))
      #t
    (let
        ((last (list-ref solution (- k 1))))
         (fold-right
          (lambda (index result)
            (define current (list-ref solution index))
            (if (not result)
                result
                (and
                 (not (= last current))
                 (not (= last (+ current (- k index 1))))
                 (not (= last (- current (- k index 1)))))))
          #t
          (enumerate-interval 0 (- k 2))))))


;;(display (safe? 4 '(1 2 3 4)))
(define solutions (queens 8))
(display solutions)
(newline)
(display (length solutions))

