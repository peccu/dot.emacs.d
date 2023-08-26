(when (or
       peccu-p
       win-env-p
       ;; wsl-p
       )
  (require-with-install 'helm-emmet)
  )
