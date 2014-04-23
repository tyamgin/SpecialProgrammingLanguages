; Определите функцию, удаляющую из исходного списка элементы с четными номерами.

(defun remove-even-positions (arr)
	(if (eq nil arr)
		nil
		(append (list (car arr)) 
				(remove-even-positions (cdr (cdr arr)))
		)
	)
)

; (remove-even-positions '(1 2 3 4 5 6))
; ok