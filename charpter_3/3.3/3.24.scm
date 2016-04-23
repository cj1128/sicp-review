;; Exercise 3.24
;; Design a table constructor make-table that takes as an argument a same-key? procedure that will be used to test equality of keys

(define (make-table same-key?)
  (define (assoc key records)
    (cond
      ((null? records) #f)
      ((same-key? key (caar records)) (car records))
      (else (assoc key (cdr records)))))
  (let ((local-table (list '*table)))
    (define (lookup key-1 key-2)
      (let ((subtable (assoc key-1 (cdr local-table))))
        (if subtable
          (let ((record (assoc key-2 (cdr subtable))))
            (if record (cdr record) #f))
          #f)))
    (define (insert! key-1 key-2 value)
      (let ((subtable (assoc key-1 (cdr local-table))))
        (if subtable
          (let ((record (assoc key-2 (cdr subtable))))
            (if record
              (set-cdr! record value)
              (set-cdr! subtable
                (cons (cons key-2 value) (cdr subtable)))))
          (set-cdr! local-table
            (cons (list key-1 (cons key-2 value))
                  (cdr local-table)))))
      'ok)
    (define (dispatch m)
      (cond
        ((eq? m 'lookup-proc) lookup)
        ((eq? m 'insert-proc) insert!)
        (else (error "Unknown operation: " m))))
    dispatch))

(define table (make-table equal?))
(define put (table 'insert-proc))
(define get (table 'lookup-proc))

(put 'a 'b 100)
(put 1 2 200)
(display (get 'a 'b))
(newline)

(display (get 1 2))
(newline)

(display (get 1.0 2.0))
(newline)

(define table2 (make-table =))
(define put (table2 'insert-proc))
(define get (table2 'lookup-proc))

(put 1 2 100)
(display (get 1.0 2.0))
