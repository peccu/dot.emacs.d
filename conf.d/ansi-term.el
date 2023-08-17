(when (or
       peccu-p
       win-env-p
       wsl-p
       )
  (when (fboundp 'yas-minor-mode)
    (add-hook 'term-mode-hook
              (lambda()
                (yas-minor-mode -1)
                (setq yas-dont-activate t))))
  )
