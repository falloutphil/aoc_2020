(use-modules (ice-9 textual-ports) ;; get-string-all
	     (srfi srfi-1)) ;; drop-right

(define entry-list
  (drop-right ;; remove right-most element (from empty string?)
   (map string->number
	(string-split
	 (call-with-input-file "input.txt" get-string-all)
	 #\newline))
   1))

(display entry-list)

(define test-list '(1721 979 366 299 675 1456))


