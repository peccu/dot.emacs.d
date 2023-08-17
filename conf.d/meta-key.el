(when (or
       peccu-p
       ;; win-env-p
       ;; wsl-p
       )
  ;; Cocoa EmacsでメタキーをCommandキーにする
  (when darwin-p
    (setq ns-command-modifier 'meta)
    (setq ns-alternate-modifier 'super))
  )
