#!/usr/bin/env sh
exec guile -e '(@ (day01) main)' -s "$0" "$@"
!#

(define-module (day01)
  #:export (main)
  #:use-module (ice-9 textual-ports) ;; get-string-all
  #:use-module (srfi srfi-1) ;; drop-right
  #:use-module (srfi srfi-26)) ;; cut

;; read file entries into list
(define entry-list
  (drop-right ;; remove right-most element (from empty string?)
   (map string->number
	(string-split
	 (call-with-input-file "input.txt" get-string-all)
	 #\newline))
   1))

;; Sort small to large
(define sorted-entry-list
  (sort entry-list <))

;; inner loop for part 1
;; for each item, loop sorted values until you are > (2020-item)
(define check-candidate
  (lambda (candidate complement-list)
    (let ((candidate-complement (- 2020 candidate)))
      (let test-car ((cl complement-list))
	(cond
	 ((null? cl) #f)
	 ((> (car cl) candidate-complement) #f) 
	 ((= candidate-complement (car cl)) (car cl))
	 (#t (test-car (cdr cl))))))))

;; naively test a single binary number that
;; represents a single of combination
;; of candidates from the file.
;; A '1' includes the corresponding number
;; in the same file position as the bit position
;; A '0' means that number is not part of this
;; combination.
(define test-single-combination
  (lambda (data k single-combination)
    ;; Loop over single combination
    (let ((count 0)
	  (n (vector-length data))
	  (matches '()))
      (do ((b 0 (+ b 1))) ; init update
	  ((= b n)) ; test (no result)
	(when (logbit? b single-combination) ;; loop body
	  (set! count (+ count 1)))) ;; count nuber of '1's
      ;; If we get exactly three '1's, redo loop
      ;; and build up list (assumes sparse hits, hence loop twice)
      ;; mapping each '1' to a value in our input.
      (if (= count k)
	  (do ((b 0 (+ b 1)))
	      ((= b n))
	    (when (logbit? b single-combination)
	      (set! matches (cons (vector-ref data b) matches)))))
      matches)))
      
	
(define (main args)
  ;; outer loop - iterate input.txt testing only
  ;; viable complements using the sorted entry list
  ;; if a complement is found multiply it by the candidate
  (format #t "~%Part 1 Result: ~a~%"
	  (let loop ((el entry-list))
	    (let ((result (check-candidate (car el) sorted-entry-list)))
	      (if result (* result (car el)) (loop (cdr el))))))

  ;; naive solution to part 2
  (format #t "~%Part 2 Result: ~a~%"
	  (let* ((target 2020)
		 (c0 (car sorted-entry-list))
		 (c1 (cadr sorted-entry-list))
		 ;; the max 3rd item cannot be larger
		 ;; than the difference between the target
		 ;; and the sum of the two smallest candidates
		 (max_third_c (- target c0 c1))
		 (filtered (list->vector
			    (filter (cut <= <> max_third_c) sorted-entry-list)))
		 (n (vector-length filtered))
		 (combos (ash 1 n)) ; total possible combinations of our input data
		 (k 3))
	    (do ((i 0 (+ i 1)))
		;; combo with exactly 3 items, sum them to see if it matches target
		((or (= (apply + (test-single-combination filtered k i)) target)
		     (= i combos)) ; nothing found, give up
		 ;; if sum matches target, then print out the product
		 (apply * (test-single-combination filtered k i)))))))
  
		        
;; Run from emacs
;; (main #f)

;; https://codereview.stackexchange.com/questions/51938/get-distinct-combinations-of-numbers
;; https://codereview.stackexchange.com/questions/18398/combinations-of-list-elements
;; https://www.cs.utexas.edu/users/djimenez/utsa/cs3343/lecture25.html

;; Combinations of list that less than 2020
;; lists a and b
;; a0 -> b0, b1, b2, b3
;; a1 -> b0, b1, b2, b3

;; a0 -> b0 ... bn

;; a0 -> b0 -> c0 ... cn
;; a0 -> b0 -> c0 -> d0 ... dn

;; Take the last item and iterate it against against each items in the second last
;; this will create a list of lists (((c0 d0) (c0 d1) (c0 d2)) ((c1 d0) (c1 d1) (c1 d2))) then flatten:
;; ((c0 d0) (c0 d1) (c0 d2) (c1 d0) (c1 d1) (c1 d2))
;; Now we repeat
;; ((c0 d0) (c0 d1) (c0 d2) (c1 d0) (c1 d1) (c1 d2) .... (cn dn))
;; b0 -> ((c0 d0) (c0 d1) (c0 d2) (c1 d0) (c1 d1) (c1 d2) .... (cn dn))
;; b1 -> ((c0 d0) (c0 d1) (c0 d2) (c1 d0) (c1 d1) (c1 d2) .... (cn dn))
;; ((b0 c0 d0) (b0 c0 d1) (b0 c0 d2) (b0 c1 d0) (b0 c1 d1) (b0 c1 d2) .... (bn cn dn))

;; Requires SRFI 26
(define (combos lst)
  (if (null? lst) '(())
      (let* ((a (car lst))
             (d (cdr lst))
             (s (combos d))
             (v (map (cut cons a <>) s)))
        (append s v))))


(define (threes lst)
  (if (= (length lst) 3) (list lst)
      (let* ((a (car lst))
             (d (cdr lst))
             (s (threes d))
             (v (map (cut cons a <>) s)))
        (append s v))))

#!
(1 2)
a 1
d (2)
s (combos (2)) **
----
(2)
a 2
d ()
s (combos ()) *
----
(())
----
s (()) *
v map cons 2 (()) = ((2))
append (()) ((2)) = (() (2))
-----
s (() (2)) **
v map cons 1 (() (2)) = ((1) (1 2))
append (() (2) (1) (1 2))
!#

