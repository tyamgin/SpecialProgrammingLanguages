; Определите функцию, заменяющую в исходном списке два подряд идущих одинаковых элемента одним.

(defun two-unique (arr)
	(if (eq nil arr)
		nil
		(append (list (first arr)) 
				(two-unique (cdr (if (eq (first arr) (second arr)) (cdr arr) arr)))
		)
	)
)

; (two-unique '(3 1 1 4 5 5 5 6 6 6 6 10))
; (two-unique nil)
; (two-unique '(1))
; ok