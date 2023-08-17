(when (or
       ;; peccu-p
       win-env-p
       ;; wsl-p
       )
  (require-with-install 'go-mode)
  (add-hook 'go-mode-hook 'auto-highlight-symbol-mode)
  )
