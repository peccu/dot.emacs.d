(when (or
       peccu-p
       win-env-p
       ;; wsl-p
       )
  ;; jaunte
  ;; (require 'jaunte-plus)
  (require 'jaunte)
  (global-set-key (kbd "M-s") 'jaunte)
  )
