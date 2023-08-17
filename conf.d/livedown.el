(when (or
       peccu-p
       ;; win-env-p
       ;; wsl-p
       )
  (add-to-list 'load-path (concat user-emacs-directory "git/emacs-livedown"))
  (require 'livedown)
  )
