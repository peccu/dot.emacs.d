(when (or
       peccu-p
       win-env-p
       wsl-p
       )
  (when (fboundp 'uniquify-lines)
    (defalias 'uniquify-lines #'delete-duplicate-lines))
  )
