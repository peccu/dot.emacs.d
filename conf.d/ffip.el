(when (or
       peccu-p
       win-env-p
       ;; wsl-p
       )
  (require-with-install 'find-file-in-project)
  ;; brew install fd
  (setq ffip-use-rust-fd t)
  )
