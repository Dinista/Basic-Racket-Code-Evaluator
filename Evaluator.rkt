#lang racket
(require 2htdp/batch-io)
(require rackunit)
(require rackunit/text-ui)

; Felipe Diniz Tomás RA 110752

; Para executar o sistema chame a função main

; --------- Quantidade de testes unitários no arquivo ------------

; string-list -> number
; Esta função composta recebe uma lista de string
; itera por cada item da mesma e passa para a função find-Rackunit.
; Caso find-Rackunit retornar true,
;    itera por cada item da string list e passa para a função find-Check.
;    find-Check retornará uma lista de números.
; Caso find-Rackunit retornar false, retorna 0.
; O retorno da condição if serão somados por set-Final-Result
; que retornará um number (número toal de testes).

(define (number-Of-Test File)
   (set-Final-Result (if(member #t (map find-Rackunit File))
                      (map find-Check File)
                      (list 0)))
  )

; string -> number
; Aqui será verificado se uma string não é um comentário e se é um teste,
; retornando 1 caso seja ou 0 caso não seja.

(define (find-Check string)
  (if (= (isline-of-code string) 1)
  (cond
    [(string-contains? string "(check-not-equal?") 1]
    [(string-contains? string "(check-eqv?") 1]
    [(string-contains? string "(check-not-eqv?") 1]
    [(string-contains? string "(check-equal?") 1]
    [(string-contains? string "(check-not-eq?") 1]
    [(string-contains? string "(check-pred ") 1]
    [(string-contains? string "(check-= ") 1]
    [(string-contains? string "(check-pred ") 1]
    [(string-contains? string "(check-within ") 1]
    [(string-contains? string "(check-true ") 1]
    [(string-contains? string "(check-false ") 1]
    [(string-contains? string "(check-not-false ") 1]
    [(string-contains? string "(check-exn ") 1]
    [(string-contains? string "(check-not-exn ") 1]
    [(string-contains? string "(check-regexp-match ") 1]
    [(string-contains? string "(check-match ") 1]
    [(string-contains? string "(test-check ") 1]
    [(string-contains? string "(test-pred ") 1]
    [(string-contains? string "(test-equal?") 1]
    [(string-contains? string "(test-eq?") 1]
    [(string-contains? string "(test-eqv?") 1]
    [(string-contains? string "(test-=") 1]
    [(string-contains? string "(test-true") 1]
    [(string-contains? string "(test-false") 1]
    [(string-contains? string "(test-not-false") 1]
    [(string-contains? string "(test-exn") 1]
    [(string-contains? string "(test-not-exn") 1]
    [else 0]
  ) 0)
  )

; string -> boolean
; Aqui será verificado se uma string é um require rackunit,
; retornando true caso seja ou false caso não seja.

(define (find-Rackunit string)
  (cond
    [(string-prefix? string "(require rackunit") #t]
    [else #f]
    )
  )


; --------- Quantidade de definições no arquivo ------------

; string-list -> number
; Esta função composta recebe uma lista de string
; itera por cada item da mesma e passa para a função find-Definition.
; o retorno de find-Definition é mapeado e passado para set-Final-Result,
; que retornará um number (número total de defines).

(define (number-Of-Definitions File)
  (set-Final-Result(map find-Definition File))
  )

; string -> number
; Esta função composta verifica se a linha
; não é um comentário e tenha um define
; retornando 1 caso tenha ou 0 caso não tenha.

(define(find-Definition string)
  (if (= (isline-of-code string) 1)
  (cond
    [(string-contains? string "(define") 1]
    [else 0]
    )
  0)
  )


; --------- Quantidade total de Requires ------------

; string-list -> number
; Esta função composta recebe uma lista de string
; itera por cada item da mesma e passa para a função find-Requires.
; o retorno de find-Requires é mapeado e passado para set-Final-Result,
; que retornará um number (número total de requires).

(define (number-Of-Requires File)
  (set-Final-Result(map find-Requires File))
  )


; string -> number
; Esta função composta verifica se a linha é um require
; retornando 1 caso seja ou 0 caso não seja. 

(define(find-Requires string)
  (cond
    [(string-prefix? string "(require") 1]
    [else 0]
    )
  )


; --------- Quantidade de linhas maiores que 80 caracteres  ------------

; string-list -> number
; Esta função composta recebe uma lista de string
; itera por cada item da mesma e passa para a função find-lines-greater-80.
; o retorno de find-lines-greater-80 é mapeado e passado para set-Final-Result,
; que retornará um number (número total de linhas maiores que 80 caracteres).

(define (lines-Greater-80 File)
  (set-Final-Result (map find-lines-greater-80 File))
  )

; string -> number
; Esta função composta verifica se a linha possui tamanho maior que 80,
; retornando 1 caso tenha ou 0 caso não tenha.

(define(find-lines-greater-80 string)
  (define str-lenght (string-length string))
  (if(> str-lenght 80 ) 1 0)
  )

; --------- Quantidade de comentários ------------

; string-list -> number
; Esta função composta recebe uma lista de string
; itera por cada item da mesma e passa para a função find-Comment.
; o retorno de find-Comment é mapeado e passado para set-Final-Result,
; que retornará um number (número total de comentários).

(define (number-Of-Comments File)
  (set-Final-Result(map find-Comment File))
  )

; string -> number
; Esta função composta verifica se a entrada é um comentário,
; retornando 1 caso tenha ou 0 caso não tenha.

(define(find-Comment string)
  (cond
    [(string-contains? string "#!") 1]
    [(string-contains? string ";") 1]
    [(string-contains? string "#|") 1]
    [else 0]
    )
  )

; --------- Quantidade de linhas de código (desconsiderando linhas de comentários e vazias)  ------------

; string-list -> number
; Esta função composta recebe uma lista de string
; itera por cada item da mesma e passa para a função isline-of-code.
; o retorno de isline-of-code é mapeado e passado para set-Final-Result,
; que retornará um number (número total de linhas de código).

(define (number-Of-Lines File)
  (set-Final-Result (map isline-of-code File))
  )

; string -> number
; Esta função composta verifica se a linha é uma linha de código,
; e não um comentário,
; retornando 1 caso seja ou 0 caso não seja.

(define(isline-of-code string-with)
  (define string (string-replace string-with " " ""))
  (cond
    [(string-prefix? string "#!") 0]
    [(string-prefix? string "#!") 0]
    [(string-prefix? string ";") 0]
    [(string-prefix? string "#|") 0]
    [(non-empty-string? string) 1]
    [else 0]
    )
  )


; --------- Funções úteis ------------

; number-list -> number
; Soma todos os número de uma lista de números.

(define (set-Final-Result list)
  (apply + list)
  )


; --------- Define pontuação ------------

; number number number number number number number -> number
; Recebe a quantidade de linha de cada métrica
; e aplica os pesos respectivamente.

(define (set-score num-lines num-test num-def num-req line-80 num-comm)
  (+ (* num-lines 0.1)
     (* num-test 0.4)
     (* num-def 0.25)
     (* num-req 0.2)
     (* line-80 -0.25)
     (* num-comm 0.3))
  )


; --------- Imprime resultados ------------

; string-list string -> void
; Aqui é executado todas as métricas e exibido os resultados e pontuação.

(define (evaluator file file-Name)
  (define Name file-Name)
  (define num-test (number-Of-Test file))
  (define num-def (number-Of-Definitions file))
  (define num-req (number-Of-Requires file))
  (define line-80 (lines-Greater-80 file))
  (define num-comm (number-Of-Comments file))
  (define num-lines (number-Of-Lines file))
  (define score (set-score num-lines num-test num-def num-req line-80 num-comm))
  (printf "Nome do arquivo: ~s\n\n" Name)
  (printf "• Quantidade de linhas que contêm código:         ~a linhas.\n" num-lines)
  (printf "• Quantidade de testes unitários no código:       ~a testes.\n" num-test)
  (printf "• Quantidade de definições no código:             ~a definições.\n" num-def)
  (printf "• Quantidade de requires no código:               ~a requires.\n" num-req)
  (printf "• Quantidade de linhas maiores que 80 caracteres: ~a linhas.\n" line-80)
  (printf "• Quantidade de comentários no código:            ~a comentários.\n" num-comm)
  (printf "\nPontuação: ~a pontos\n\n" (~r score))
  (printf "--------------------\n")
  (printf "\n")
  )

; --------- Função main ------------
(define (main)
  (printf "\n")
  (printf "Avaliador de código racket\n")
  (printf "====================\n")
  (printf "\n")
  (read-Files)
  )

; --------- Leitura de arquivos ------------

; função que mapea o diretório files
; e transforma o caminho para cada arquivo em uma string
; adiconando em uma lista (Files).
; Após isso itera em cada item da lista e executa evaluator
; tendo como paramêtros uma lista de string (todas as linhas de um arquivo)
; gerada por read-lines (função da biblioteca batch-io).

(define (read-Files)
  (let
    ((Files(map path->string(directory-list "files/" #:build? #t))))
    (for ([File Files])
      (evaluator(read-lines File) (get-File-Name File))
     )
   )
 )

; string -> string 
; função composta que pega o nome do arquivo
; em uma string no formato path 

(define (get-File-Name File)
  (string-replace File "files/" "")
 )


; --------- Testes ------------

(define qnt-defines-test
  (test-suite "Quantidade de definições no código"
             (check-equal? (number-Of-Definitions (read-lines "examples-for-tests/test-define.rkt")) 3)
             ))

(define qnt-unit-tests-test
  (test-suite "Quantidade de testes unitários no código"
             (check-equal? (number-Of-Test (read-lines "examples-for-tests/test-unit-tests.rkt")) 4)
             ))

(define qnt-requires-test
  (test-suite "Quantidade de requires no código"
             (check-equal? (number-Of-Requires (read-lines "examples-for-tests/test-require.rkt")) 3)
             ))

(define qnt-lines-greater-80-test
  (test-suite "Quantidade de linhas maiores que 80 caracteres"
             (check-equal? (lines-Greater-80 (read-lines "examples-for-tests/test-lines-greater-80.rkt")) 2)
             ))

(define qnt-comments-test
  (test-suite "Quantidade de comentários no código"
             (check-equal? (number-Of-Comments (read-lines "examples-for-tests/test-comment.rkt")) 6)
             ))

(define qnt-lines-test
  (test-suite "Quantidade de linhas do código"
             (check-equal? (number-Of-Lines (read-lines "examples-for-tests/test-number-of-lines.rkt")) 3)
             ))

(define get-file-name-test
  (test-suite "Pega o nome do arquivo"
             (check-equal? (get-File-Name "files/Nome.rkt") "Nome.rkt")
             ))

(define final-result-test
  (test-suite "Soma todos os números de uma lista de números"
             (check-equal? (set-Final-Result (list 0 1 0 1 0 1)) 3)
             ))

(define set-score-test
  (test-suite "Aplica os pesos para a pontuação final"
             (check-equal? (set-score 182 2 24 4 0 49) 40.5)
             ))

; Executa um conjunto de testes.

(define (run-all-tests . tests)
  (run-tests (test-suite "Todos os testes" tests))
  (void))

; Chama a função para executar todos os testes.

(run-all-tests qnt-comments-test
               qnt-lines-greater-80-test
               qnt-requires-test
               qnt-unit-tests-test
               qnt-defines-test
               qnt-lines-test
               get-file-name-test
               final-result-test
               set-score-test)


