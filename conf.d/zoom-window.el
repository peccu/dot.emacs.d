(when (or
       peccu-p
       win-env-p
       ;; wsl-p
       )
  (require-with-install 'zoom-window)
  ;; overwrite windows.el
  (eval-after-load 'windows
    (define-key win:switch-map (kbd "SPC") 'zoom-window-zoom))
  )
