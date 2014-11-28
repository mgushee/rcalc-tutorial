#lang racket
(require racket/control)

(define (mkcalc)
  (define (calc q)
    (eval `(,(cadr q) ,(caddr q) ,(car q))))
  (define (queue-full? q)
    (>= (length q) 3))
  (define q '())
  (prompt
    (λ (input)
      (set! q (cons input q))
      (call/cc
        (λ (k)
          (if (queue-full? q)
              (let ((result (calc q)))
                (set! q '())
                (k `(result ,result)))
              (k 'ok)))))))