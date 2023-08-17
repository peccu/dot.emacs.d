(when (or
       peccu-p
       win-env-p
       wsl-p
       )
  (defalias 'string-to-int #'string-to-number)
  )
