(when (or
       peccu-p
       win-env-p
       ;; wsl-p
       )
  (require 'trans-regions)
  (define-key global-map (kbd "C-c t") 'trans-regions)
  )
