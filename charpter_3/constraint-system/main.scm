; Constraint System

;; Implementation

;; basic connector operatios

;; API
;; (has-value? <connector>)
;; (get-value <connector>)
;; (set-value! <connector> <value> <informant>)
;; (forget-value! <connector> <retractor>)
;; (connect <connector> <constraint>)

(define (has-value? connector)
  (connector 'has-value?))
(define (get-value connector)
  (connector 'value))
(define (set-value! connector new-value setter)
  ((connector 'set-value!) new-value setter))
(define (forget-value! connector retractor)
  ((connector 'forget-value!) retractor))
(define (connect connector constraint)
  ((connector 'connect) constraint))

(define (make-connector)
  (let ((value #f) (informant #f) (constraints '()))
    (define (set-my-value! new-value setter)
      (cond
        ((not (has-value? me))
         (set! value new-value)
         (set! informant setter)
         (for-each-except setter inform-about-value constraints))
        ((not (= value new-value))
         (error "Contradiction" (list value new-value)))
        (else 'ignored)))
    (define (forget-my-value! retractor)
      (if (eq? retractor informant)
          (begin
            (set! informant #f)
            (for-each-except retractor inform-about-no-value constraints))
          'ignored))
    (define (connect new-constraint)
      (if (not (memq new-constraint constraints))
          (set! constraints
                (cons new-constraint constraints)))
      (if (has-value? me)
          (inform-about-value new-constraint))
      'done)
    (define (me request)
      (cond
        ((eq? request 'has-value?) (if informant #t #f))
        ((eq? request 'value) value)
        ((eq? request 'set-value!) set-my-value!)
        ((eq? request 'forget-value!) forget-my-value!)
        ((eq? request 'connect) connect)
        (else (error "Unknown operation: CONNECTOR" request))))
    me))

(define (for-each-except exception procedure list)
  (define (loop items)
    (cond
      ((null? items) 'done)
      ((eq? (car items) exception)
       (loop (cdr items)))
      (else (procedure (car items))
            (loop (cdr items)))))
  (loop list))


;; basic constraint
(define (adder a1 a2 sum)
  (define (process-new-value)
    (cond ((and (has-value? a1) (has-value? a2))
           (set-value! sum
                       (+ (get-value a1) (get-value a2))
                       me))
          ((and (has-value? a1) (has-value? sum))
           (set-value! a2
                       (- (get-value sum) (get-value a1))
                       me))
          ((and (has-value? a2) (has-value? sum))
           (set-value! a1
                       (- (get-value sum) (get-value a2))
                       me))))

  (define (process-forget-value)
    (forget-value! a1 me)
    (forget-value! a2 me)
    (forget-value! sum me)
    (process-new-value))

  (define (me request)
    (cond
      ((eq? request 'I-have-a-value) (process-new-value))
      ((eq? request 'I-lost-my-value) (process-forget-value))))
  (connect a1 me)
  (connect a2 me)
  (connect sum me)
  me)

(define (multiplier m1 m2 product)
  (define (process-new-value)
    (cond
      ((or (and (has-value? m1) (= (get-value m1) 0))
           (and (has-value? m2) (= (get-value m2) 0)))
        (set-value! product 0 me))
      ((and (has-value? m1) (has-value? m2))
       (set-value! product
                   (* (get-value m1) (get-value m2))
                   me))
      ((and (has-value? m1) (has-value? product))
       (set-value! m2
                  (/ (get-value product) (get-value m1))
                  me))
      ((and (has-value? m2) (has-value? product))
       (set-value! m1
                  (/ (get-value product) (get-value m2))
                  me))))
  (define (process-forget-value)
    (forget-value! product me)
    (forget-value! m1 me)
    (forget-value! m2 me)
    (process-new-value))
  (define (me request)
    (cond
      ((eq? request 'I-have-a-value) (process-new-value))
      ((eq? request 'I-lost-my-value) (process-forget-value))))
  (connect m1 me)
  (connect m2 me)
  (connect product me)
  me)

(define (constant value connector)
  (define (me request)
    (error "Unknown request: CONSTANT" request))
  (connect connector me)
  (set-value! connector value me)
  me)

(define (probe name connector)
  (define (print-probe value)
    (newline) (display "Probe: ") (display name)
    (display " = ") (display value))
  (define (process-new-value)
    (print-probe (get-value connector)))
  (define (process-forget-value) (print-probe "?"))
  (define (me request)
    (cond
      ((eq? request 'I-have-a-value) (process-new-value))
      ((eq? request 'I-lost-my-value) (process-forget-value))))
  (connect connector me)
  me)


;; common functions
(define (inform-about-value constraint)
  (constraint 'I-have-a-value))
(define (inform-about-no-value constraint)
  (constraint 'I-lost-my-value))
