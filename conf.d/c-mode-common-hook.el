(when (or
       peccu-p
       win-env-p
       wsl-p
       )
  (add-hook 'c-mode-common-hook 'auto-highlight-symbol-mode)
  )
