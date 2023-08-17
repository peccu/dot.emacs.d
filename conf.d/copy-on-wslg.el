;; for running in wslg with pgtk
;; https://emacsredux.com/blog/2021/12/19/using-emacs-on-windows-11-with-wsl2/
(defun copy-selected-text (start end)
  (interactive "r")
  (if (use-region-p)
      (let ((text (buffer-substring-no-properties start end)))
        (shell-command (concat "echo '" text "' | clip.exe")))))
(when (and
       (eq system-type 'gnu/linux)
       (eq window-system 'pgtk))
  (global-set-key (kbd "M-w") 'copy-selected-text))
