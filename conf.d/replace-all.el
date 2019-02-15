;; Emacs Lispテクニックバイブル p.111 replace-regexp-in-lisp より
(defun replace-all (regexp to-string)
  "Emacs Lispテクニックバイブル p.111 replace-regexp-in-lisp より"
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward regexp nil t)
      (replace-match to-string))))
