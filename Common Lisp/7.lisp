; Определите функцию, удаляющую из исходного списка элементы с четными номерами.

(defun non-recursive-remove-even-positions (arr)
	(setq position 0)
	(setq result nil)
	(dolist (value arr result)
			(if (= (mod position 2) 0) 
				(setq result (append result (list value)))
			)
			(setq position (+ 1 position))
	)
)

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