;;; rcalc-engine.rkt -- Handle input and perform calculations.
;;;   Copyright © 2014 by Matthew C. Gushee <matt@gushee.net>
;;;   This program is open-source software, released under the BSD license.
;;;   See the accompanying LICENSE file for details.

#lang racket/base
(require racket/match
         racket/class
         data/queue)

;(provide (all-defined-out))
(provide rcengine%)

(define rcengine%
  (class object%

    (super-new)

    (field [q (make-queue)])
    (field [state '(initial)])
    (field [pending-op #f])

    ;; Calculator operations
    (define/public (put signal)
      (match `(,(get-state) ,signal)
        [`(,st +) (set-pending! 'plus)]
        [`(,st -) (set-pending! 'minus)]
        [`(,st *) (set-pending! 'mult)]
        [`(,st /) (set-pending! 'div)]
        [`(,st =) (calc)]
        [`(,st (enter ,x)) (enqueue! q x)]))

    (define/private (get-state)
      (let ((st (car state)))
        (unless (eqv? st 'initial)
          (set! state (cdr state)))
        st))

    (define/private (set-pending! signal)
      (unless (memv signal '(plus minus mult div))
        (error (format "Invalid operator: ~a\n" signal)))
      (set! pending-op signal))

    (define/private (calc)
      (define op
        (case pending-op
          ((plus) +)
          ((minus) -)
          ((mult) *)
          ((div) /)
          (else #f)))
      (if op
        (let ((result (apply op (queue->list q))))
          (set! q (make-queue))
          result)
        (dequeue! q)))))




;;; IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
;;; ------------------------------------------------------------------------

;;; OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO

;;; ========================================================================
;;; ------------------------------------------------------------------------


