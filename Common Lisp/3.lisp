; Определите функцию, заменяющую в исходном списке все вхождения заданного значения другим.

(defun list-replace (subject search replace)
	(if (eq nil subject) 
		nil
		(append (list (if (eq (car subject) search) replace (car subject))) 
				(list-replace (cdr subject) search replace)
		)
	)
)

; (list-replace '(1 2 3 4 5 4 7 8) 4 999)
; ok