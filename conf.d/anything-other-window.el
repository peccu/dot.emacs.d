(when (or
       peccu-p
       ;; win-env-p
       ;; wsl-p
       )
  (when (version< emacs-version "29")
    (require 'anything-c-source-other-windows)
    )
  )
