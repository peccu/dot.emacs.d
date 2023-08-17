(when (or
       peccu-p
       win-env-p
       wsl-p
       )
  (require-with-install 'wdired)
  (define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)
  )
