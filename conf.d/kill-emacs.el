(when (or
       peccu-p
       win-env-p
       ;; wsl-p
       )
  (setq confirm-kill-emacs 'y-or-n-p)
)
