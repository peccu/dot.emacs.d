(when (or
       ;; peccu-p
       win-env-p
       wsl-p
       )
  (require-with-install 'all-the-icons)
  (setq inhibit-compacting-font-caches t)
  ;; M-x all-the-icons-install-fonts
  (when (require 'all-the-icons-dired nil t)
    (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))
  )
