(when (or
       peccu-p
       win-env-p
       wsl-p
       )
  (require-with-install 'point-stack)
  ;; window local stack
  (global-set-key (kbd "C-c m") 'point-stack-push)
  (global-set-key (kbd "C-c p") 'point-stack-pop)
  (global-set-key (kbd "C-c f") 'point-stack-forward-stack-pop)
  )
