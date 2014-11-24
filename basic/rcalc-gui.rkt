#lang racket/gui
(require "./rcalc-engine.rkt")

(define (run-calc)
  (define engine (new rcengine%))

  (define (on-button-m+ btn evt) (send engine put 'M+))
  (define (on-button-m- btn evt) (send engine put 'M-))
  (define (on-button-mc btn evt) (send engine put 'MC))
  (define (on-button-mr btn evt) (send engine put 'MR))
  (define (on-button-<- btn evt) (send engine put 'bs))
  (define (on-button-ce btn evt) (send engine put 'CE))
  (define (on-button-ac btn evt) (send engine put 'AC))
  (define (on-button-lp btn evt) (send engine put 'lp))
  (define (on-button-rp btn evt) (send engine put 'rp))
  (define (on-button-rc btn evt) (send engine put 'rc))
  (define (on-button-% btn evt) (send engine put '%))
  (define (on-button-+- btn evt) (send engine put 'pm))
  (define (on-button-sq btn evt) (send engine put 'sq))
  (define (on-button-sr btn evt) (send engine put 'sr))
  (define (on-button-fn btn evt) (send engine put 'fn))
  (define (on-button-7 btn evt) (send engine put '(digit "7")))
  (define (on-button-8 btn evt) (send engine put '(digit "8")))
  (define (on-button-9 btn evt) (send engine put '(digit "9")))
  (define (on-button-/ btn evt) (send engine put '/))
  (define (on-button-4 btn evt) (send engine put '(digit "4")))
  (define (on-button-5 btn evt) (send engine put '(digit "5")))
  (define (on-button-6 btn evt) (send engine put '(digit "6")))
  (define (on-button-* btn evt) (send engine put '*))
  (define (on-button-1 btn evt) (send engine put '(digit "1")))
  (define (on-button-2 btn evt) (send engine put '(digit "2")))
  (define (on-button-3 btn evt) (send engine put '(digit "3")))
  (define (on-button-- btn evt) (send engine put '-))
  (define (on-button-0 btn evt) (send engine put '(digit "0")))
  (define (on-button-pt btn evt) (send engine put 'pt))
  (define (on-button-= btn evt) (send engine put '=))
  (define (on-button-+ btn evt) (send engine put '+))

  (define calc-frame%
    (class frame%
      (super-new)
      (define (on-size w h)
        (right-align w))
      (override on-size)))
  (define mainwin (new calc-frame% [label "Racket Calculator | Basic"]))
  (define num-display (new text-field% [parent mainwin]
                                       [label ""]
                                       [init-value "0"]
                                       [enabled #f]))
  (define (right-align w)
    (let ((ed (send num-display get-editor)))
      (send ed set-max-width (- w 16))
      (send ed set-paragraph-alignment 0 'right)))
  (define button-area (new horizontal-pane% [parent mainwin]))
  (define column1 (new vertical-pane% [parent button-area]))
  (define column2 (new vertical-pane% [parent button-area]))
  (define column3 (new vertical-pane% [parent button-area]))
  (define column4 (new vertical-pane% [parent button-area]))
  (define button-m+ (new button% [parent column1] [label "M+"]
                                 [stretchable-width #t] [stretchable-height #t]))
  (define button-m- (new button% [parent column2] [label "M-"]
                                 [stretchable-width #t] [stretchable-height #t]))
  (define button-mc (new button% [parent column3] [label "MC"]
                                 [stretchable-width #t] [stretchable-height #t]))
  (define button-mr (new button% [parent column4] [label "MR"]
                                 [stretchable-width #t] [stretchable-height #t]))
  (define button-<- (new button% [parent column1] [label "<-"]
                                 [stretchable-width #t] [stretchable-height #t]))
  ;(define spacer (new pane% [parent column2]))
  (define spacer (new button%    [parent column2] [label ""] [enabled #f]
                                 [stretchable-width #t] [stretchable-height #t]))
  (send spacer show #f)
  (define button-ce (new button% [parent column3] [label "CE"]
                                 [stretchable-width #t] [stretchable-height #t]))
  (define button-ac (new button% [parent column4] [label "AC"]
                                 [stretchable-width #t] [stretchable-height #t]))
  (define button-lp (new button% [parent column1] [label "("]
                                 [stretchable-width #t] [stretchable-height #t]))
  (define button-rp (new button% [parent column2] [label ")"]
                                 [stretchable-width #t] [stretchable-height #t]))
  (define button-rc (new button% [parent column3] [label "1/x"]
                                 [stretchable-width #t] [stretchable-height #t]))
  (define button-% (new button%  [parent column4] [label "%"]
                                 [stretchable-width #t] [stretchable-height #t]))
  (define button-+- (new button% [parent column1] [label "+-"]
                                 [stretchable-width #t] [stretchable-height #t]))
  (define button-sq (new button% [parent column2] [label "^2"]
                                 [stretchable-width #t] [stretchable-height #t]))
  (define button-sr (new button% [parent column3] [label "sqrt"]
                                 [stretchable-width #t] [stretchable-height #t]))
  (define button-fn (new button% [parent column4] [label "f()"]
                                 [stretchable-width #t] [stretchable-height #t]))
  (define button-7 (new button%  [parent column1] [label "7"]
                                 [stretchable-width #t] [stretchable-height #t]))
  (define button-8 (new button%  [parent column2] [label "8"]
                                 [stretchable-width #t] [stretchable-height #t]))
  (define button-9 (new button%  [parent column3] [label "9"]
                                 [stretchable-width #t] [stretchable-height #t]))
  (define button-/ (new button%  [parent column4] [label "/"]
                                 [stretchable-width #t] [stretchable-height #t]))
  (define button-4 (new button%  [parent column1] [label "4"]
                                 [stretchable-width #t] [stretchable-height #t]))
  (define button-5 (new button%  [parent column2] [label "5"]
                                 [stretchable-width #t] [stretchable-height #t]))
  (define button-6 (new button%  [parent column3] [label "6"]
                                 [stretchable-width #t] [stretchable-height #t]))
  (define button-* (new button%  [parent column4] [label "*"]
                                 [stretchable-width #t] [stretchable-height #t]))
  (define button-1 (new button%  [parent column1] [label "1"]
                                 [stretchable-width #t] [stretchable-height #t]))
  (define button-2 (new button%  [parent column2] [label "2"]
                                 [stretchable-width #t] [stretchable-height #t]))
  (define button-3 (new button%  [parent column3] [label "3"]
                                 [stretchable-width #t] [stretchable-height #t]))
  (define button-- (new button%  [parent column4] [label "-"]
                                 [stretchable-width #t] [stretchable-height #t]))
  (define button-0 (new button%  [parent column1] [label "0"]
                                 [stretchable-width #t] [stretchable-height #t]))
  (define button-pt (new button% [parent column2] [label "."]
                                 [stretchable-width #t] [stretchable-height #t]))
  (define button-= (new button%  [parent column3] [label "="]
                                 [stretchable-width #t] [stretchable-height #t]))
  (define button-+ (new button%  [parent column4] [label "+"]
                                 [stretchable-width #t] [stretchable-height #t]
                                 [callback on-button-+]))

  (send mainwin show #t)
  (right-align (- (send mainwin get-width) 4)))
