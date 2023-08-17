(when (or
       ;; peccu-p
       win-env-p
       ;; wsl-p
       )
  ;; curl -Lo ~/AppData/Roaming/.emacs.d/lisp/color-moccur.el https://github.com/emacsmirror/color-moccur/raw/master/color-moccur.el
  (require 'color-moccur)
  ;; this includes dmoccur
  (global-set-key (kbd "C-M-o") 'dmoccur)
  ;; dired moccur marked files
  (add-hook 'dired-mode-hook ;dired
            '(lambda ()
               (local-set-key (kbd "O") 'dired-do-moccur)))

  ;; curl -Lo ~/AppData/Roaming/.emacs.d/lisp/moccur-edit.el https://github.com/emacsmirror/emacswiki.org/raw/master/moccur-edit.el
  (when (locate-library "moccur-edit")
    (require 'moccur-edit))
  )
