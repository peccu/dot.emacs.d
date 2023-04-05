;; Emacs Lispテクニックバイブル p.111 replace-regexp-in-lisp より
(defun replace-all (regexp to-string)
  "Emacs Lispテクニックバイブル p.111 replace-regexp-in-lisp より"
  (save-excursion
    (goto-char (point-min))
    (replace-all-from-here regexp to-string)))

(defun replace-all-from-here (regexp to-string)
  (save-excursion
    (while (re-search-forward regexp nil t)
      (replace-match to-string))))

(defun query-replace-all (from-string to-string)
  (save-excursion
    (query-replace from-string to-string nil (point-min) (point-max))))
