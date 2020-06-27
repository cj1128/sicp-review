;; Exercise 2.74
;; Use data-direct programming solving division files problem

;; a)
(define (get-record division name)
  ((get division 'record) name))

;; b)
(define (get-salary division record)
  ((get division 'salary) record))

;; c)
(define (find-employee-record name divisions)
  (if (null? divisions)
      #f
      (or
       (get-record (car divisions) name)
       (find-employee-record name (cdr divisions)))))

;; d)
;; the new company should install its record and salary generic procedure into the lookup table using its name as the first key
