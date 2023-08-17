(when (or
       peccu-p
       ;; win-env-p
       ;; wsl-p
       )
  (require 'descbinds-anything)
  (descbinds-anything-install)
  )
