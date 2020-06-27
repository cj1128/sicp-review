;; Exercise 4.10
;; Say, we change define keyword with 'defun', then all we have to do is
;; change definition?
;; there is no modification needed to eval or apply

(define (definition? exp) (tagged-list 'defun))
