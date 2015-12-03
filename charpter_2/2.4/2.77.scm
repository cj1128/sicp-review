;; Exercise 2.77

;; z =  ('complex ('rectangular (3 . 4)))

;; (magnitude z)
;; -> (apply-generic 'magnitude z)
;; -> ((get 'magnitude '(complex)) z)
;; -> (real-part ('rectangular (3 . 4)))
;; -> (apply-generic 'real-part z1)
;; -> ((get 'real-part '(reactangular)))
;; -> this is the actuall operation

