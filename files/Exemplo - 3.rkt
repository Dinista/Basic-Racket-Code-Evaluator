#lang racket/gui
;Ignorați următoarele linii de cod. Conțin import-uri și export-uri necesare checker-ului.

(require 2htdp/image)
(require 2htdp/universe)
(require lang/posn)
(require racket/trace)
(make-predictive '(42))
;---------------------------------------checker_exports------------------------------------------------
(provide next-state)
(provide next-state-bird)
(provide next-state-bird-onspace)
(provide change)

(provide get-pipes)
(provide get-pipe-x)
(provide next-state-pipes)
(provide add-more-pipes)
(provide clean-pipes)
(provide move-pipes)

(provide invalid-state?)
(provide check-ground-collision)
(provide check-pipe-collisions)

(provide draw-frame)

(provide get-initial-state)
(provide get-bird)
(provide get-bird-y)
(provide get-bird-v-y)

; pipe
(provide get-pipes)
(provide get-pipe-x)

; score25
(provide get-score)

(provide get-abilities)
(provide get-abilities-visible)
(provide get-abilities-active)
; variables
(provide get-variables)
(provide get-variables-gravity)
(provide get-variables-momentum)
(provide get-variables-scroll-speed)

;---------------------------------------checker_exports------------------------------------------------
;
;Initial state

;TODO 1
; (get-initial-state) va fi o funcție care va returna starea inițială a jocului.
(define-struct gen-bird (x y v-y) #:transparent)
(define-struct pipe (gap-y x) #:transparent)
(define-struct gen-state (bird pipes score) #:transparent)

(define(check-pred dsad dsad))
;TODO 16

; și trebuie apelată în restul codului.
(define (get-initial-state)
  (define bird (gen-bird bird-x bird-initial-y 0))
  (define state (gen-state bird '()  0))
  (struct-copy gen-state state [pipes (cons (pipe (+ added-number (random random-threshold)) scene-width) (gen-state-pipes state))])
  )

;TODO 2
; După aceasta, implementați un getter care extrage din structura voastră
; pasărea, și un al doilea getter care extrage din structura pasăre
; y-ul curent pe care se află această.
(define (get-bird state)
  (gen-state-bird state))

(define (get-bird-y bird)
  (gen-bird-y bird))

(define (get-bird-x bird)
  (gen-bird-x bird))

;TODO 3
; Trebuie să implementăm logică gravitației. next-state-bird va primi drept
; parametri o structură de tip pasăre, și gravitația(un număr real). Aceasta va adaugă
; pozitiei pe y a păsării viteza acesteia pe y, si va adaugă vitezei pe y a păsării,
; gravitația.
(define (next-state-bird bird gravity)
(struct-copy gen-bird bird [y (+ (get-bird-y bird) (get-bird-v-y bird))] [v-y (+ (get-bird-v-y bird) gravity)]))

;TODO 4
; După aceasta, implementati un getter care extrage din structura voastră
; viteza pe y a păsării.
(define (get-bird-v-y bird)
  (gen-bird-v-y bird))

;TODO 6
; Dorim să existe un mod prin care să imprimăm păsării un impuls.
; Definiți funcția next-state-bird-onspace care va primi drept parametri
; o structură de tip pasăre, momentum(un număr real), și va schimba viteza
; pe y a păsării cu -momentum.
(define (next-state-bird-onspace bird momentum)
(struct-copy gen-bird bird [v-y (- 0 momentum)]))

(define (change current-state pressed-key)
(if equal? pressed-key " ") current-state
(struct-copy gen-state current-state [bird (next-state-bird-onspace (gen-state-bird current-state) initial-momentum)])
)


;TODO 9
; După ce ați definit structurile pentru mulțimea de pipes și pentru un singur pipe,
; implementați getterul get-pipes, care va extrage din starea jocului mulțimea de pipes,
; sub formă de lista.
(define (get-pipes state)
  (gen-state-pipes state))

;TODO 10
; Implementați get-pipe-x ce va extrage dintr-o singură structura de tip pipe, x-ul acesteia.
(define(get-pipe-x pipe)
  (pipe-x pipe))

(define(get-pipe-y pipe)
  (pipe-gap-y pipe))

;TODO 11
; Trebuie să implementăm logica prin care se mișcă pipes.
; Funcția move-pipes va primi drept parametri mulțimea pipe-urilor din stare
; și scroll-speed(un număr real). Aceasta va scădea din x-ul fiecărui pipe
; scroll-speed-ul dat.
(define (move-pipes pipes scroll-speed)
  (map (lambda (x) (struct-copy pipe x [x (- (pipe-x x) scroll-speed)])) pipes)
  )

;TODO 12
; Vom implementa logica prin care pipe-urile vor fi șterse din stare. În momentul
; în care colțul din DREAPTA sus al unui pipe nu se mai află pe ecran, acesta trebuie
; șters.
; Funcția va primi drept parametru mulțimea pipe-urilor din stare.
;
; Hint: cunoaștem lățimea unui pipe, pipe-width
(define (clean-pipes pipes)
(filter (lambda(x) (if (<=  ( + (pipe-x x) pipe-width) 0) #f #t)) pipes)
  )



;TODO 13
; Vrem să avem un sursa continuă de pipe-uri. Implementati funcția add-more-pipes, care va primi drept parametru mulțimea pipe-urilor
; din stare și, dacă avem mai puțin de no-pipes pipe-uri, mai adăugăm una la mulțime, având x-ul egal cu pipe-width + pipe-gap + x-ul celui mai îndepărtat pipe, în raport
; cu pasărea.
(define (add-more-pipes pipes)
  (if (< (length pipes) no-pipes)
  (cons (pipe (+ added-number (random random-threshold)) (+ (+ pipe-width pipe-gap) (get-pipe-x (last pipes)))) pipes)
  pipes))

;TODO 14

; și va apela cele trei funcții implementate anterior, în această ordine: move-pipes, urmat de clean-pipes, urmat de add-more pipes.
(define (next-state-pipes pipes scroll-speed)
(add-more-pipes (clean-pipes (move-pipes pipes scroll-speed))))
  

;TODO 17
; Creați un getter ce va extrage scorul din starea jocului.
(define (get-score state)
  (gen-state-score state))


;TODO 19
; mai mare sau egal cu cel al pământului.
(define (check-ground-collision bird)
 (if (>= (+ (get-bird-y bird) bird-height) ground-y) #t #f))

; invalid-state?
; invalid-state? îi va spune lui big-bang dacă starea curentă mai este valida,
; sau nu. Aceasta va fi validă atât timp cât nu avem coliziuni cu pământul
; sau cu pipes.
; Aceasta va primi ca parametru starea jocului.

;TODO 20
; Vrem să integrăm verificarea coliziunii cu pământul în invalid-state?.

;TODO 22
; Odată creată logică coliziunilor dintre pasăre și pipes, vrem să integrăm
(define (invalid-state? state)
  (or (check-ground-collision (get-bird state)) (check-pipe-collisions (get-bird state) (get-pipes state))))

;TODO 21
; Odată ce am creat pasărea, pipe-urile, scor-ul și coliziunea cu pământul, ; următorul pas este verificarea coliziunii dintre pasăre și pipes.

(define (check-pipe-collisions bird pipes)
   (if (member #t (map (lambda (x) (or
             (check-collision-rectangles (make-posn bird-x (get-bird-y bird)) (make-posn (+ (get-bird-x bird) bird-width ) (+ (get-bird-y bird) bird-height))
                                         (make-posn (get-pipe-x x) 0) (make-posn (+ (get-pipe-x x) pipe-width)  (get-pipe-y x) )) 

             (check-collision-rectangles (make-posn bird-x (get-bird-y bird)) (make-posn (+ (get-bird-x bird) bird-width ) (+ (get-bird-y bird) bird-height))
                                         (make-posn (get-pipe-x x) (+ (get-pipe-y x) pipe-self-gap)) (make-posn (+ (get-pipe-x x) pipe-width) pipe-height))))
                       pipes))#t #f))

(define (check-collision-rectangles A1 A2 B1 B2)
  (match-let ([(posn AX1 AY1) A1]
              [(posn AX2 AY2) A2]
              [(posn BX1 BY1) B1]
              [(posn BX2 BY2) B2])
    (and (< AX1 BX2) (> AX2 BX1) (< AY1 BY2) (> AY2 BY1))))
;(trace check-pipe-collisions)

;TODO 5
; Trebuie să integrăm funcția implementată anterior, și anume next-state-bird,
; în next-state.

;TODO 15
; Vrem să implementăm logică legată de mișcarea, ștergerea și adăugarea pipe-urilor
; în next-state. Acesta va apela next-state-pipes pe pipe-urile din starea curentă.

;TODO 18
; Vrem ca next-state să incrementeze scorul cu 0.1 la fiecare cadru.
(define (next-state state)
    (struct-copy gen-state state [bird (next-state-bird (gen-state-bird state) initial-gravity)]
                 [pipes (next-state-pipes (get-pipes state) initial-scroll-speed)][score (+ (get-score state) 0.1)]))


;TODO 23
; scor -> text-x si text-y
; pipes -> pipe-width si pipe-height
(define bird-image (rectangle bird-width bird-height  "solid" "yellow"))
(define ground-image (rectangle scene-width ground-height "solid" "brown"))
(define initial-scene (rectangle scene-width scene-height "solid" "white"))

(define text-family (list "Gill Sans" 'swiss 'normal 'bold #f))
(define (score-to-image x)
(if SHOW_SCORE
	(apply text/font (~v (round x)) 24 "indigo" text-family)
	empty-image))

(define (draw-frame state)
  (place-image bird-image
                        (+ (get-bird-x (get-bird state)) (quotient bird-width 2))
                           (+ (get-bird-y (get-bird state)) (quotient bird-height 2))
                           (place-image ground-image (/ scene-width 2) (- scene-height (/ ground-height 2))
                           (place-image (score-to-image (get-score state)) text-x text-y  (place-pipes (get-pipes state) initial-scene))))
                           )

; Folosind `place-image/place-images` va poziționa pipe-urile pe scenă.
(define (place-pipes pipes scene)
(if (null? pipes) scene   
  (place-pipes (cdr pipes) (place-image (rectangle pipe-width pipe-self-gap  "solid" "white")
                                       (+ (get-pipe-x (car pipes)) (/ pipe-width 2) )  (+ (get-pipe-y (car pipes)) (/ pipe-self-gap 2))
                                (place-image (rectangle pipe-width pipe-height "solid" "green")
                                             (+ (get-pipe-x (car pipes)) (/ pipe-width 2)) (/ pipe-height 2) scene )))
  ))






(define slow-ability 'your-code-here)

; Abilitatea care va accelera timpul va dura 30 de secunde, va avea imaginea (hourglass "tomato"); va avea inițial poziția null si va modifica scrolls-speed dupa formulă hourglass hourglass
(define fast-ability 'your-code-here)

; lista cu toate abilităţile posibile în joc (define ABILITIES (list fast-ability slow-ability))
(define get-variables 'your-code-here)
(define get-variables-gravity 'your-code-here)
(define get-variables-momentum 'your-code-here)
(define get-variables-scroll-speed 'your-code-here)

; Întoarce abilităţile din stare, cu o reprezentare
; intermediară care trebuie să conțină două liste:
;  - lista abilităţilor vizibile (încarcate în scenă dar nu neaparat vizibile pe ecran).
;  - lista abilităţilor activate (cu care pasărea a avut o coloziune).hourglass 
(define (get-abilities x) null)

; Întoarce abilităţile vizibile din reprezentarea intermediară.
(define (get-abilities-visible x) null)

; Întoarce abilităţile active din reprezentarea intermediară.
(define (get-abilities-active x) null)

; Șterge din reprezentarea abilităţilor vizibile pe cele care nu mai sunt vizibile.
; echivalent cu clean-pipes.
(define (clean-abilities abilities)
	'your-code-here)


; Muta abilităţile vizibile spre stanga.
(define (move-abilities abilities scroll-speed)
	'your-code-here)


; Scurge timpul pentru abilităţile activate și le sterge pe cele care au expirat.

(define (time-counter abilities)
	'your-code-here)


; Folosiți funcția fill-abilities din abilities.rkt cât si cele scrise mai sus:

(define (next-abilities-visible visible scroll-speed)
	'your-code-here)


; nu au coliziuni cu pasărea sau puteti folosi `partition`
(define (next-abilities abilities bird scroll-speed)
	'your-code-here)


; initial-variables și nu variabilele aflate deja în stare
; In felul acesta atunci când
(define (next-variables variables abilities)
  'your-code-here)


; Folosind `place-image/place-images` va poziționa abilităţile vizibile la ability pos.
(define (place-visible-abilities abilities scene)
	'your-code-here)


; Imaginea cu indexul i va fi așezată la (ability-posn.x - 50*i, ability-posn.y)
(define (place-active-abilities abilities scene)
	'your-code-here)

(module+ main
	(big-bang (get-initial-state)
	 [on-tick next-state (/ 1.0 fps)]
	 [to-draw draw-frame]
	 [on-key change]
	 [stop-when invalid-state?]
	 [close-on-stop #t]
	 [record? #f]))
