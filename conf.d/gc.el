(when (or
       ;; peccu-p
       win-env-p
       ;; wsl-p
       )
  (setq gc-cons-threshold 100000000)
)
