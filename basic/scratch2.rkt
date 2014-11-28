#lang racket
(require data/queue)
(require racket/match)

;(define-syntax eval-unit
;  (syntax-rules ()
;    [(eval-unit `(,exp1 ,op ,exp2))
;     (eval `(,op ,(eval-unit exp1) ,(eval-unit exp2)))]
;    [(eval-unit x)
;     x]))

(define (eval-unit u)
  (match u
    [(list exp1 op exp2) (eval `(,op ,(eval-unit exp1) ,(eval-unit exp2)))]
    [(list exp) (eval-unit exp)]
    [exp exp]))

(struct calc-unit
  ([op #:auto]
   [n1 #:auto]
   [n2 #:auto])
  #:mutable
  #:auto-value #f)
  
;(define (mk-calc)
;  (define digits '())
;  (define (getnum)
;    (let ((num (string->number (list->string digits))))
;      (set! digits '())
;      num))
;  (define (calc chr)
;    #f))
    