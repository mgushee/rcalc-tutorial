;;; rcalc-engine.rkt -- Handle input and perform calculations.
;;;   Copyright © 2014 by Matthew C. Gushee <matt@gushee.net>
;;;   This program is open-source software, released under the BSD license.
;;;   See the accompanying LICENSE file for details.

#lang racket/base
(require racket/match
         racket/pretty
         data/queue
         srfi/14)

(provide mk-engine)

(define (mk-engine)
  (define pending-op +)
  (define total 0)
  (define digits '())
  (define (digits->num)
    (let ((n (string->number (list->string (reverse digits)))))
      (set! digits '())
      n))
  (define (calc)
    (set! total (eval `(,pending-op ,total ,(digits->num))))
    (set! pending-op #f))
  (λ (input)
     (cond
       ((and (char? input)
             (char-set-contains? char-set:digit input))
        (set! digits (cons input digits))
        'ok)
       ;; Hmm ... why would this happen?
       ((and (procedure? input)
             (null? digits))
        'ok)
       ((procedure? input)
        (calc)
        (set! pending-op input)
        `(result ,total))
       (else
         'error))))
