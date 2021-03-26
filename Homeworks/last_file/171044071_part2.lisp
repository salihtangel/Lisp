(setq x (open "boundries.txt"))
(setq m (read x))
(setq n(read x) )
(if
    (= m 1)
        (setq m (+ m 1))
    )

(defun is_prime (*x*)

(setq i 2)
(setq counter 0)
(loop
  ( if (= (mod *x* i) 0)
       (setq counter(+ counter 1))
    )
  (setq i(+ i 1))
   (when (<= *x* i) (return t))
  )
  (if (= counter 0)
   (with-open-file (str "primedistribution.txt"
                     :direction :output
                     :if-exists :append
                     :if-does-not-exist :create)
      (format str   " is prime ~a ~%" *x*)
)
      )
)
(loop
        (is_prime  m)
       ;(is_semi_prime  a )  yazdim ama tam dogru sonuc vermedigi icin eklemekten vazgectim
        (setq m (+ m 1))
        (when (> m n) (return))
      )


