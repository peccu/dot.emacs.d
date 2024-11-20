(when (or
       peccu-p
       win-env-p
       wsl-p
       )
  (require 'smerge-mode)
  (define-key smerge-mode-map (kbd "C-c ^ n") 'smerge-vc-next-conflict)
  )
