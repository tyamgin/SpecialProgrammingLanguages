; Определите функцию (ЛУКОВИЦА п), строящую N-уровневый вложенный список, элементом которого на самом глубоком уровне является N.! 

(defun LUK (N &optional (what N))
	(if (= 0 N) 
		what 
		(list (LUK (- N 1) what))
	)
)

; ok