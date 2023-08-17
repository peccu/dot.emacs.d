(when (or
       peccu-p
       win-env-p
       ;; wsl-p
       )
  (ffap-bindings)
  ;; swap to default find-alternate-file
  (global-set-key (kbd "C-x C-v") 'find-alternate-file)
  )
