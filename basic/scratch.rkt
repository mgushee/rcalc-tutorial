#lang racket/base
(require srfi/14)

(define seq1
  '(#\2 #\1 #\- #\( #\1 #\4 #\0 #\0 #\+ #\5 #\6 #\) #\* #\( #\7 #\3 #\- #\4 #\4 #\) #\=))

(define seq2
  '(#\2 #\1 #\3 #\/ #\( #\5 #\9 #\* #\( #\6 #\4 #\9 #\- #\7 #\4 #\) #\)))

#| 2 1 3 / (
    5 9 * (
        6 4 9 - 7 4
    )
  )) |#

(define (calc)
  (define total 0)
  (define pending-op #f)
  (define input '())
  (define (update-total)
    (let ((input* (string->number (list->string (reverse input)))))
      (set! total
        (if pending-op
          (pending-op total input*)
          input*)))
    (set! input '())
    (print total))
  (define (clear)
    (set! total 0)
    (set! pending-op #f)
    (set! input '()))
  (lambda (ch)
    (cond 
      ((eqv? ch #\+)
        (update-total) (set! pending-op +))
      ((eqv? ch #\-)
        (update-total) (set! pending-op -))
      ((eqv? ch #\*)
        (update-total) (set! pending-op *))
      ((eqv? ch #\/)
        (update-total) (set! pending-op /))
      ((eqv? ch #\=)
        (update-total) (clear))
      ((char-set-contains? char-set:digit ch)
        (set! input (cons ch input)))
      (else
        (error (format "Invalid input: ~a\n" ch))))))
