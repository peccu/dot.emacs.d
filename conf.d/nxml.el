(add-to-list 'auto-mode-alist '("\\.tpl\\'" . nxml-mode))
(add-hook 'nxml-mode-hook
          '(lambda ()
             (define-key nxml-mode-map (kbd "M-}") 'forward-paragraph)
             (define-key nxml-mode-map (kbd "M-{") 'backward-paragraph)))
