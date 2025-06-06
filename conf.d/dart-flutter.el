(when (or
       peccu-p
       win-env-p
       ;; wsl-p
       )
  (require-with-install 'dart-mode)
  (require-with-install 'flutter)

  (define-key dart-mode-map (kbd "C-c C-c") 'flutter-run-or-hot-reload)
  ;; (setq flutter-sdk-path "")
  )
