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

;; inner loop
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


(define (main args)
  ;; outer loop - iterate input.txt testing only
  ;; viable complements using a sorted list
  ;; if a complement is found multiply it by the candidate
  (format #t "~%Result: ~a~%"
	  (let loop ((el entry-list))
	    (let ((result (check-candidate (car el) (sort entry-list <))))
	      (if result (* result (car el)) (loop (cdr el)))))))
	
;; Run from emacs
;; (main #f)
