(when (or
       peccu-p
       win-env-p
       wsl-p
       )
  (require-with-install 'coffee-mode)
  (add-hook 'coffee-mode-hook 'auto-highlight-symbol-mode)
  ;; This gives you a tab of 2 spaces
  (custom-set-variables '(coffee-tab-width 2))
  (add-hook 'coffee-mode-hook
            (lambda ()
              (set (make-local-variable 'tab-width) 2)
              (set (make-local-variable 'indent-tabs-mode) t)))
  )
