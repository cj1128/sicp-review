;; Exercise 3.48

;; using this method, we will alwasys attempt to lock the smaller-numbered
;; account, so a waits b and b waits a would never happen

(define (serialize-exchange account1 account2)
  (let ((serializer1 (account1 'serializer))
        (serializer2 (account2 'serializer))
        (id1 (account1 'id))
        (id2 (account2 'id)))
    (if (< id1 id2)
        ((serializer2 (serializer1 exchange))
         account2
         account1)
        ((serializer1 (serializer2 exchange))
         account1
         account2))))
