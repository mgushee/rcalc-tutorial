#lang racket/base

(require rackunit
         "./rcalc-engine.rkt")

(test-case
  "1 + 1 ="
  (let ((engine (mk-engine)))
    (check eqv? (engine #\1) 'ok)
    (check eqv? (engine #\+) 'ok)
    (check eqv? (engine #\1) 'ok)
    (check eqv? (engine #\=) '(result 2))))

(test-case
  "1 + 2 + 3 ="
  (let ((engine (mk-engine)))
    (check eqv? (engine #\1) 'ok)
    (check eqv? (engine #\+) 'ok)
    (check eqv? (engine #\2) 'ok)
    (check eqv? (engine #\+) '(result 3))
    (check eqv? (engine #\3) 'ok)
    (check eqv? (engine #\=) '(result 6))))

(test-case
  "1024 - 384 ="
  (let ((engine (mk-engine)))
    (check eqv? (engine #\1) 'ok)
    (check eqv? (engine #\0) 'ok)
    (check eqv? (engine #\2) 'ok)
    (check eqv? (engine #\4) 'ok)
    (check eqv? (engine #\-) 'ok)
    (check eqv? (engine #\3) 'ok)
    (check eqv? (engine #\8) 'ok)
    (check eqv? (engine #\4) 'ok)
    (check eqv? (engine #\=) '(result 640))))
