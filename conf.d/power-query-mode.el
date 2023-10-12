(when (or
       ;; peccu-p
       win-env-p
       ;; wsl-p
       )

  (add-submodule-to-load-path "git/power-query-mode")
  )
