#lang racket
(require rackunit)

;exemplos de teste

;deve ser contado
(define test1
  (test-suite "Teste 1"
             (check-equal? 4 3)
             ))

;deve ser contado
(define test2
  (test-suite "Teste 2"
             (check-not-eqv?  4 3)
             ))
;deve ser contado
(define test3
  (test-suite "Teste 2"
             (check-true  4 3) ;dasdasd 
             ))

;deve ser contado
(test-equal? "Teste 3" 4 3)


;não deve ser contado
;(test-equal? "Teste comentado" 4 3)
;(define test-comment
;  (test-suite "Teste comentado"
;              (check-false  4 3)
;             ))

; quantidade de testes esperados: 4