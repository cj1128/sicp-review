;; Code to test constraint system
(load "main.scm")

(define (celsius-fahrenheit-convertor c f)
  (let ((u (make-connector))
        (v (make-connector))
        (w (make-connector))
        (x (make-connector))
        (y (make-connector)))
    (multiplier c w u)
    (multiplier v x u)
    (adder v y f)
    (constant 9 w)
    (constant 5 x)
    (constant 32 y)
    'ok))

(define C (make-connector))
(define F (make-connector))

(celsius-fahrenheit-convertor C F)

(probe "Celsius temp" C)
(probe "Fahrenheit temp" F)

(set-value! C 25 'user)
 ;Probe: Celsius temp = 25
 ;Probe: Fahrenheit temp = 77
 ;done

;(set-value! F 212 'user)
;Error! Contradiction (77 212)

(forget-value! C 'user)
;Probe: Celsius temp = ?
;Probe: Fahrenheit temp = ?
;done

(set-value! F 212 'user)
;Probe: Fahrenheit temp = 212
;Probe: Celsius temp = 100
;done
