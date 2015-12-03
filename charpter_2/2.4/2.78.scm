;; Exercise 2.78
;; Modify the definition of type-tag, contents and attach-tag so that our generic system takes advantage of scheme's internal type system. That's to say, we can represent oridinary numbers as scheme numbers without adding 'scheme-number tag

(define (type-tag datum)
  (cond
   ((number? datum) 'scheme-number)
   ((pair? datum) (car datum))
   (else (error "Bad tagged datum: TYPE-TAG" datum))))

(define (contents datum)
  (cond
   ((number? datum) datum)
   ((pair? datum) (cdr datum))
   (else (error "Bad tagged datum: CONTENTS" datum))))

(define (attach-tag tag contents)
  (if (number? contents) contents
      (cons tag contents)))
