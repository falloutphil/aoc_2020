(use-modules (ice-9 textual-ports)
	     (srfi srfi-1))

(define entry-list
  (drop-right
   (map string->number
	(string-split
	(call-with-input-file "input.txt" get-string-all)
	#\newline)) 1))

(display entry-list)

(define test-list '(1721 979 366 299 675 1456))


