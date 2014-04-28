; Определите функцию, находящую максимальное из значений, находящихся в вершинах дерева.

(defun get-max-in-tree (tree)
	(if (atom tree)
		tree
		(if (null (cdr tree))
			(get-max-in-tree (car tree))
			(max
				(get-max-in-tree (car tree))
				(get-max-in-tree (cdr tree))
			)
		)
	)
)
; (get-max-in-tree '(1))
; (get-max-in-tree '(((1)(6))(((7)))(((8)(9))(-1)(((13)(9))))) )