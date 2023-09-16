(when (or
       peccu-p
       win-env-p
       ;; wsl-p
       )
  (require-with-install 'docker)
  (require-with-install 'dockerfile-mode)
  (add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))
  (require-with-install 'docker-compose-mode)
  ;; (require-with-install 'docker-tramp-compat)
  ;; (set-variable 'docker-tramp-use-names t)
  )
