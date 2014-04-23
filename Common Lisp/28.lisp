; Определите функцию, вычисляющую, сколько всего атомов в списке (списочной структуре).

(defun count-atoms (arr)
	(cond ((eq nil arr) 0)
		  ((atom (car arr)) (+ 1 (count-atoms (cdr arr))))
		  (T (count-atoms (cdr arr)))
	)
)

; ok