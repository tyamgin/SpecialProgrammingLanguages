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
	(or (eq (get x mom) (get y mom))
		(eq (get x mom) (get y dad))
		(eq (get x dad) (get y mom))
		(eq (get x dad) (get y dad))
	)
)

(setf (get 'vasya 'mom) 'alena)

('vasya put 'mom 'alena)
('vasya put 'dad 'boris)
('petya put 'mom 'alena)
('petya put 'dad 'boris)
('eugene put 'mom 'olga)
('eugene put 'dad 'egor)
