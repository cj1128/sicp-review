; This procedure is similar to `accumulate` except that it takes
; as its third argument a sequence of sequences, which are all assumed to have
; the same number of elements. It applies the designated accumulation procedure
; to combine all the first elements of the sequences, all the second elements
; of the sequences, and so on, and returns a sequence of the results.
; For instance, (accumulate-n + 0 '((1 2 3) (4 5 6) (7 8 9) (10 11 12)))
; should be the sequence (22 26 30)
(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      '()
      (cons (accumulate op init
                        (map car seqs))
            (accumulate-n op init
                          (map cdr seqs)))))
