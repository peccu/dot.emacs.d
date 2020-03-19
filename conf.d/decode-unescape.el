;; https://emacs.stackexchange.com/a/3142
(eval-after-load 'web-mode
  '(progn
     (defalias 'decode-xml-escape 'web-mode-dom-entities-replace)
     (defalias 'unescape-xml-entities 'web-mode-dom-entities-replace)
     ))

;; https://emacs.stackexchange.com/a/3141
(defalias 'decode-entities
  (if (fboundp 'libxml-parse-html-region) 'decode-entities/libxml 'decode-entities/xml.el))

(defun decode-entities/xml.el (html)
  (with-temp-buffer
    (save-excursion (insert html))
    (xml-parse-string)))

(defun decode-entities/libxml (html)
  (with-temp-buffer
    (insert html)
    (let ((document
           (libxml-parse-html-region (point-min) (point-max))))
      (pcase document
        (`(html nil
                (body nil
                      (p nil
                         ,(and (pred stringp)
                               content))))
         content)
        (_ (error "Unexpected parse result: %S" document))))))
