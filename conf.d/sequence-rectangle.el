(when (or
       peccu-p
       win-env-p
       ;; wsl-p
       )
  (require 'my-sequence-rectangle)
  (define-key ctl-x-map "rN" 'my-sequence-rectangle)
  )
