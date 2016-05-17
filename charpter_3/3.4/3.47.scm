;; Exercise 3.47
;; Implements semaphores using mutex or atomic tet-and-set! operations


;; using mutex
(define (make-semaphore n)
  (let ((lock (make-mutex)) (count 0))
    (define (semaphore m)
      (cond ((eq? m 'acquire)
             (lock 'acquire)
             (if (= count n)
                (begin
                 (lock 'release)
                 (semaphore 'acquire))
                (begin
                  (set! count (+ count 1))
                  (lock 'release))))
            ((eq? m 'release)
              (lock 'acquire)
              (if (= count 0)
                  (lock 'release)
                  (begin
                    (set! count (- count 1))
                    (lock 'release))))))
    semaphore))

(define (make-semaphore n)
  (let ((cell (list #f)) (count n))
    (define (semaphore m)
      (cond ((eq? m 'acquire)
             (if (test-and-set! cell)
                 (semaphore 'acquire)
                 (if (= count n)
                     (begin
                       (clear! cell)
                       (semaphore 'acquire))
                     (begin
                       (set! n (+ n 1))
                       (clear! cell)))))
            ((eq? m 'release)
             (if (test-and-set! cell)
                 (semaphore 'release)
                 (if (= count 0)
                     (clear! cell)
                     (begin
                       (set! count (- count 1))
                       (clear cell!)))))))
    semaphore))
