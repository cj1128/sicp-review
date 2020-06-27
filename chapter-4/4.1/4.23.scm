;; Exercise 4.23
;; Alyssa expected analyze-sequence to look like this:

;; (define (analyze-sequence exps)
;;   (define (execute-sequence procs env)
;;     (if (null? (cdr procs))
;;         ((car procs) env)
;;         (begin
;;           ((car procs) env)
;;           (execute-sequence (cdr procs) env))))
;;   (let ((procs (map analyze exps)))
;;     (if (null? procs)
;;         (error "Empty sequence: ANALYZE")
;;         (lambda (env)
;;           (execute-sequence procs env)))))

;; Compare the above version of analyze-sequence to the version in th text

;; Alyssa's version would add some runtime overhead because execute-sequence will loop the list and make conditional test(if)
;; But analyze-sequence in the text is a single lambda which can be directly
;; executed with no overhead.
