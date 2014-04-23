; Определите функцию, добавляющую элементы одного списка во второй список, начиная с заданной позиции.

(defun split (arr first-size)
	(setq i 0)
	(setq left nil)
	(setq right nil)
	(dolist (value arr)
			(if (< i first-size)
				(setq left (append left (list value)))
				(setq right (append right (list value)))
			)
			(setq i (+ 1 i))
	)
	(list left right)
)

; (split '(1 2 3 4 5) 3)

(defun non-recursive-insert (to position what)
	(setq parts (split to position))
	(append (car parts) what (car (cdr parts)))
)

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