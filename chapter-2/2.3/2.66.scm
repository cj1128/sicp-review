(define (lookup given-key records)
  (if
    (null? records) false
    (let
      ((entry-key (key (entry records))))
      (cond
        ((= given-key entry-key) (entry records))
        ((< given-key entry-key)
         (lookup given-key (left-branch records)))
        ((> given-key entry-key)
         (lookup given-key (right-branch records)))))))
