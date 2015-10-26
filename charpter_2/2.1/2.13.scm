;; Exercise 2.13

;; first interval: a(1-b) a(1+b)
;; second interval: c(1-d) c(1+d)
;; product: ac(1-b)(1-d) ac(1+b)(1+d)
;; = ac(1-b-d-bd) ac(1+b+d+bd)
;; cause b and is are small numbers, so we can ignore bd
;; = ac(1-b-d) ac(1+b+d)
;; so the tolerance of product is the sum of tolerances of factors


