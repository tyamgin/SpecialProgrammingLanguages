; Определите функцию ПЕРЕСЕЧЕНИЕ, формирующую пересечение двух множеств, т.е. множество из их общих элементов.

(defun intersect (a b)
	(cond ((eq nil a) nil)
		  ((member (car a) b) (append (list (car a)) (intersect (cdr a) b)))
		  (T (intersect (cdr a) b))
	)
)


; (intersect '(1 2 3 4 5) '(3 4 5 6 7))
; ok