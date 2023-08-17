(when (or
       peccu-p
       ;; win-env-p
       ;; wsl-p
       )
  (defconst *dmacro-key* (kbd "<f7>") "繰返し指定キー")
  (require 'dmacro)
  (global-set-key *dmacro-key* 'dmacro-exec)
  )
