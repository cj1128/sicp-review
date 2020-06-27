;; Exercise 2.66
;; Implement the lookup procedure for the case where the set of records is structured as a binary tree

(define (lookup given-key records)
  (if
   (null? records) #f
   (let
       ((entry-key (key (entry records))))
     (cond
      ((= given-key entry-key) (entry records))
      ((< given-key entry-key)
       (lookup given-key (left-branch records)))
      ((> given-key entry-key)
       (lookup given-key (right-branch records)))))))
