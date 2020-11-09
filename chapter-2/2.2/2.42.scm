(load "flatmap.scm")

; inclusive, [start, end]
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
                   (enumerate-interval 1 board-size)))
            (queen-cols (- k 1))))))
  (queen-cols board-size))

(define empty-board '())

(define (adjoin-position new-row rest-of-queens)
  (append rest-of-queens (list new-row)))

(define (safe? k solution)
  (if (or
        (= (length solution) 0)
        (= (length solution) 1))
      true
      (let
        ((last (list-ref solution (- k 1))))
        (fold-right
          (lambda (index result)
            (define current (list-ref solution index))
            (if (not result)
                result
                (and
                  (not (= last current))
                  (not (= last (+ current (- k 1 index))))
                  (not (= last (- current (- k 1 index)))))))
          true
          (enumerate-interval 0 (- k 2))))))

(define solutions (queens 8))

(for-each (lambda (x) (display x) (newline)) solutions)
(newline)

(display (length solutions))

