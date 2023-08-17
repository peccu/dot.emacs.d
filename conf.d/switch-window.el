(when (or
       peccu-p
       win-env-p
       ;; wsl-p
       )
  (require-with-install 'switch-window)
  (global-set-key (kbd "C-:") 'switch-window)
  )
