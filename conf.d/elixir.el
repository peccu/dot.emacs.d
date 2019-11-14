(require 'elixir-mode)
(require 'alchemist)
(add-hook 'elixir-mode-hook 'ac-alchemist-setup)
(add-hook 'elixir-mode-hook
          (lambda () (add-hook 'before-save-hook 'elixir-format nil t)))
(add-to-list 'auto-mode-alist '("\\.leex\\'" . elixir-mode))
