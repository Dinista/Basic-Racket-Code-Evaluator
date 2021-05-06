#lang racket

; exemplos de requires

;deve ser contado
(require 2htdp/batch-io)
;deve ser contado
(require rackunit)
;deve ser contado
(require 2htdp/image 2htdp/universe)

; não deve ser contado
;(require 2htdp/batch-io)

;quantidade de require esperados: 3


