; Определите функцию, вычисляющую, сколько всего атомов в списке (списочной структуре).

(defun count-atoms (arr)
	(length (mapcan #'(lambda (x) (if (atom x) (list T) nil)) arr))
)