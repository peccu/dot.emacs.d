(add-to-list 'auto-mode-alist '("\\.tpl\\'" . nxml-mode))
(add-hook 'nxml-mode-hook
          '(lambda ()
             (setq nxml-child-indent 2
                   nxml-attribute-indent 2)
             (define-key nxml-mode-map (kbd "M-}") 'forward-paragraph)
             (define-key nxml-mode-map (kbd "M-{") 'backward-paragraph)))
