(when (or
       peccu-p
       win-env-p
       ;; wsl-p
       )
  (require-with-install 'elixir-mode)
  (require-with-install 'alchemist)
  (add-hook 'elixir-mode-hook 'ac-alchemist-setup)
  (add-hook 'elixir-mode-hook
            (lambda () (add-hook 'before-save-hook 'elixir-format nil t)))
  (add-to-list 'auto-mode-alist '("\\.leex\\'" . elixir-mode))
  (add-hook 'elixir-mode-hook 'auto-highlight-symbol-mode)
  )
