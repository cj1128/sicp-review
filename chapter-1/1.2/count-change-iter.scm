(define (count-change amount)
  (define (iter ways half-dollar quarter dime nickle)
    (cond
      ((> (* half-dollar 50) amount) ways) ; stop
      ((> (+
            (* half-dollar 50)
            (* quarter 25))
          amount)
       (iter ways (+ 1 half-dollar) 0 0 0))
      ((> (+
            (* half-dollar 50)
            (* quarter 25)
            (* dime 10))
          amount)
       (iter ways half-dollar (+ 1 quarter) 0 0))
      ((> (+
            (* half-dollar 50)
            (* quarter 25)
            (* dime 10)
            (* nickle 5))
          amount)
       (iter ways half-dollar quarter (+ 1 dime) 0))
      (else (iter (+ 1 ways) half-dollar quarter dime (+ 1 nickle)))))
  (iter 0 0 0 0 0))

(display (count-change 6))
