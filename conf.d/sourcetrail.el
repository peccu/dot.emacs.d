(when (or
       ;; peccu-p
       ;; win-env-p
       ;; wsl-p
       )
  (add-submodule-to-load-path "git/emacs-sourcetrail")
  (require 'sourcetrail)
  ;; M-x sourcetrail-mode for renderer
  ;; M-x sourcetrail-send-loation to send location to SourceTrail
  )
