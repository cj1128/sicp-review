;; Exercise 3.25
;; Implements a table in which values are stored under an arbitrary number of keyss
;; and different values may be stored under different number of keyss

(define (list-equal? l1 l2)
  (cond
   ((null? l1) (if (null? l2) #t #f))
   ((null? l2) (if (null? l1) #t #f))
   (else
    (if (equal? (car l1) (car l2))
        (list-equal? (cdr l1) (cdr l2))
        #f))))

(define (make-table)
  (define (assoc keys records)
    (cond
     ((null? records) #f)
     ((list-equal? keys (caar records)) (car records))
     (else (assoc keys (cdr records))))
    )
  (let ((local-table (list '*table)))
    (define (lookup keys)
      (let ((record (assoc keys (cdr local-table))))
        (if record
            (cdr record)
            #f)))
    (define (insert! keys value)
      (let ((record (assoc keys (cdr local-table))))
        (if record
            (set-cdr! record value)
            (set-cdr! local-table
                      (cons (cons keys value)
                            (cdr local-table))))))
    (define (dispatch m)
      (cond
       ((eq? m 'lookup-proc) lookup)
       ((eq? m 'insert-proc) insert!)))
    dispatch))

(define table (make-table))
(define get (table 'lookup-proc))
(define put (table 'insert-proc))

(put '(1 2 3 4) 1234)
(put '(1 2 3) 123)
(display (get '(1 2 3 4)))
(newline)

(display (get '(1 2 3)))
(newline)
