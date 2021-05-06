#lang racket

; Exemplo de define comum (deve ser contado)
(define a 2)

; Exemplo de define comentado (não deve ser contado)
;(define a 2)

; Exemplo define comum e define indentado (deve ser contado os dois)
(define foo1
  (let ()
    (define (bar n) ; e comentado
      (+ n n))
    (bar 1)))

; Valor esperado de quantidade de defines: 3. 