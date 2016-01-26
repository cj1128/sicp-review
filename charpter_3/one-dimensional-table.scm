;; Implements a one dimensional table

(define (lookup key table)
  (let ((record (assoc key (cdr table))))
    (if record
        (cdr record)
        #f)))
(define (assoc key records)
  (cond
    ((null? records) #f)
    ((equal? (caar records) key) (car records))
    (else (assoc key (cdr records)))))

(define (insert! key value table)
  (let ((record (assoc key (cdr table))))
    (if record
        (set-cdr! record value)
        (set-cdr! table
                  (cons (cons key value)
                        (cdr table))))
    'ok))

(define (make-table)
  (list '*table*))
