;)
(defun fun (n)
(with-open-file (str "collatz_outputs.txt"
                     :direction :output
                     :if-exists :append
                     :if-does-not-exist :create)
      (format str   "~d: " n))

  (loop
  (cond
     ((= 0 (mod n 2))
        (setq n (/ n 2))
        (with-open-file (str "collatz_outputs.txt"
                     :direction :output
                     :if-exists :append
                     :if-does-not-exist :create)
      (format str   " ~d" n)))

        ((= 1 (mod n 2))
        (setq n (+ (* n 3) 1))
        (with-open-file (str "collatz_outputs.txt"
                     :direction :output
                     :if-exists :append
                     :if-does-not-exist :create)
      (format str   " ~d" n)))
    )
  (when (= n 2) (return ))
  )
 (with-open-file (str "collatz_outputs.txt"
                     :direction :output
                     :if-exists :append
                     :if-does-not-exist :create)
      (format str   " 1 ~%"))
 )

(setq x (open "integer_inputs.txt"))
(setq a (read x))
(setq b(read x) )
(setq c(read x) )
(setq d(read x) )
(setq e(read x) )
(setq f(read x) )
(setq g(read x) )
(setq h(read x) )



(fun a)
(fun b)
(fun c)
(fun d)
(fun e)
(fun f)
(fun g)
(fun h)



