(when (or
       peccu-p
       win-env-p
       wsl-p
       )
  (load (concat user-emacs-directory "lisp/popup-color-at-point.el"))
  (global-set-key (kbd "C-c c") 'popup-color-at-point)
  )
