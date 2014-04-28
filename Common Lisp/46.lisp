; .Предположим, что отец и мать некоторого лица, хранятся как значения соответствующих свойств у символа, обозначающего это лицо. 
;  Напишите функцию
; (РОДИТЕЛИ х)
;    которая возвращает в качестве значения родителей, и предикат
; (СЕСТРЫ-БРАТЬЯ x1 x2)
;    который истинен в случае, если x1 и х2 — сестры или братья, родные или с одним общим родителем.

(defun parents (x)
	(list (get x 'mom) (get x 'dad))
)

(defun brother (x y)
	(or (eq (get x 'mom) (get y 'mom))
		(eq (get x 'dad) (get y 'dad))
	)
)

(setf (get 'vasya 'mom) 'alena)
(setf (get 'vasya 'dad) 'boris)
(setf (get 'petya 'mom) 'alena)
(setf (get 'petya 'dad) 'boris)
(setf (get 'eugene 'mom) 'olga)
(setf (get 'eugene 'dad) 'egor)

(parents 'vasya)
(brother 'petya 'vasya)
(brother 'petya 'eugene)






