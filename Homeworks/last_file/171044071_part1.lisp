(with-open-file (stream "nested_list.txt")
 (with-open-file (str "flattened_list.txt"
                     :direction :output
                     :if-exists :supersede
                     :if-does-not-exist :create)
   
  (format str "(")

  (do (
       (char (read-char stream nil)
       (read-char stream nil)))
       ((null char))
       (let (= char str))

       (if (and
             (char/= char #\()
             (char/= char #\))
             (char/= char #\tab)
             (char/= char #\newline)
             )
           
          (format str (string (character char)) )

       )
   )
  (format str ")")
  )
)

