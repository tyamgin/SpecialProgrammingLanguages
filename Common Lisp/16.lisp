; Определите функцию, добавляющую элементы одного списка во второй список, начиная с заданной позиции.

(defun insert (to position what)
	(if (= 1 position)
		(append what to)
		(append (list (car to))
				(insert (cdr to) (- position 1) what)
		)
	)
)

; (insert '(1 2 3 4 5) 3 '(-1 -2))
; ok