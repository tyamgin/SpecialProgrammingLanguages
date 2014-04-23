; Определите предикат РАВЕНСТВО-МНОЖЕСТВ, проверяющий совпадение двух множеств (независи мо от порядка следования элементов). 
; Подсказка: используйте функцию REMOVE, удаляющую данный элемент из множества.

(defun is-subset (subset where)
	(if (eq nil subset)
		T
		(and (member (car subset) where)
			 (is-subset (cdr subset) where)
		)
	)
)

(defun is-equal-sets (A B)
	(and (is-subset A B) (is-subset B A))
)

; (is-equal-sets '(1 3 2) '(2 3 1))
; ok