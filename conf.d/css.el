(when (or
       peccu-p
       win-env-p
       wsl-p
       )
  (add-hook 'css-mode-hook
            (lambda ()
              (make-local-variable 'css-indent-offset)
              (setq css-indent-offset 2)))
  )
