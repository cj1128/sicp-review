(define (make-wire)
  (let ((signal-value 0) (action-procedures '()))
    (define (set-signal! new-value)
      (if (not (= signal-value new-value))
          (begin
            (set! signal-value new-value)
            (call-each action-procedures))
          'done))
    (define (add-action! proc)
      (set! action-procedures
            (cons proc action-procedures))
      (proc))
    (define (dispatch m)
      (cond
        ((eq? m 'get-signal) signal-value)
        ((eq? m 'set-signal!) set-signal!)
        ((eq? m 'add-action!) add-action!)
        (else (error "Unknown operation: WIRE" m))))
    dispatch))

(define (call-each procedures)
  (if (null procedures)
      'done
      (begin ((car procedures))
        (call-each (cdr procedures)))))

(define (get-signal wire) (wire 'get-signal))
(define (set-signal! wire value) ((wire 'set-signal!) value))
(define (add-action! wire action) ((wire 'add-action!) action))
