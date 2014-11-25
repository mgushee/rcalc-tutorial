#lang racket/base

(require rackunit
         "./rcalc-engine.rkt")

(test-case
  "1 + 1 ="
  (let ((engine (new rcengine%)))
    (check eqv? (send engine put #\1) 'ok)
    (check eqv? (send engine put #\+) 'ok)
    (check eqv? (send engine put #\1) 'ok)
    (check eqv? (send engine put #\=) '(result 2))))

(test-case
  "1 + 2 + 3 ="
  (let ((engine (new rcengine%)))
    (check eqv? (send engine put #\1) 'ok)
    (check eqv? (send engine put #\+) 'ok)
    (check eqv? (send engine put #\2) 'ok)
    (check eqv? (send engine put #\+) '(result 3))
    (check eqv? (send engine put #\3) 'ok)
    (check eqv? (send engine put #\=) '(result 6))))

(test-case
  "1024 - 384 ="
  (let ((engine (new rcengine%)))
    (check eqv? (send engine put #\1) 'ok)
    (check eqv? (send engine put #\0) 'ok)
    (check eqv? (send engine put #\2) 'ok)
    (check eqv? (send engine put #\4) 'ok)
    (check eqv? (send engine put #\-) 'ok)
    (check eqv? (send engine put #\3) 'ok)
    (check eqv? (send engine put #\8) 'ok)
    (check eqv? (send engine put #\4) 'ok)
    (check eqv? (send engine put #\=) '(result 640))))
