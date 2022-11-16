
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below
(define (sequence low high stride)
    (if (> low  high) 
        (list)
        (cons low (sequence (+ low stride) high stride )))
    )

(define (string-append-map xs suffix)
    (map (lambda (x) (string-append x suffix ))  xs ) )


(define (list-nth-mod xs n)
    (cond [(< n 0) (error "list-nth-mod: negative number") ]
          [(null? xs) (error "list-nth-mod: empty list") ] 
          [#t (car (list-tail xs (remainder n (length xs)) ) ) ]
           ) )

(define (stream-for-n-steps s n)
    (if (= n 0)
        (list)
        (letrec ([result (s)]) (cons (car result) (stream-for-n-steps (cdr result ) (- n 1)))  ) 
        ))

(define (funny-number-stream)
    (letrec ([f (lambda (x) (cons (if (= (remainder x 5) 0 ) (- x) x )  (lambda () (f (+ x 1)) )) )])  
        (f 1) )
    )

(define (dan-then-dog)
    (letrec ([f (lambda (x) (cons (if (= (remainder x 2) 0 ) "dog.jpg" "dan.jpg" )  (lambda () (f (+ x 1)) )) )])  
        (f 1) )
)

(define (stream-add-zero s)
    (lambda ()  
    (letrec (  [f (lambda (x) (let ([result (s)])  (cons (cons 0 (car result) )  (lambda () (f (cdr result)) )) )  )])  
        (f s) )
     )
 )

(define (cycle-lists xs ys) 
    (lambda ()  
    (letrec ([f (lambda (xs_ ys_ x) (cons (cons (list-nth-mod xs_ x) (list-nth-mod ys_ x  )    )  (lambda () (f xs_ ys_ (+ x 1)) )) )])  
        (f xs ys 0) )
)
)

(define (vector-assoc v vec )
    (letrec ([f (lambda (v_ vec_  n) 
               (cond   
                 [(equal? (vector-length vec_) (+ n 1)) #f ]   
                 [#t (let ([e (vector-ref vec_ n)]) (if (pair? e )  (if (equal? v (car e))  e  (f v vec_ (+ n 1 ))   )  (f v vec_  (+ n 1 ))     )  )]
               )
           )])  
        (f v vec 0 )
     )
 )

(define (cached-assoc xs n)
    (letrec ([memo (make-vector n #f )])
        (lambda (v)  
            (let ([v_cache (vector-ref memo (- v 1)) ]) 
               (if v_cache (car v_cache) 
                (let ([v_new (assoc v  xs )]  )
                    (begin (vector-set! memo (- v 1) (list v_new ))
                        v_new 
                    )        
                 )   
                )
               )
        )
    )
 )







