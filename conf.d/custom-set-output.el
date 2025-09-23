(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ahs-default-range 'ahs-range-whole-buffer)
 '(anzu-deactivate-region t)
 '(anzu-mode-lighter "")
 '(anzu-replace-to-string-separator " => ")
 '(anzu-search-threshold 1000)
 '(coffee-tab-width 2)
 '(dmoccur-recursive-search t)
 '(helm-buffer-max-length 60)
 '(lsp-tailwindcss-add-on-mode t)
 '(magit-display-buffer-function 'magit-display-buffer-same-window-except-diff-v1)
 '(moccur-following-mode-toggle nil)
 '(moccur-grep-default-word-near-point t)
 '(moccur-grep-following-mode-toggle nil)
 '(package-archives
   '(("org" . "https://orgmode.org/elpa/")
     ("melpa" . "https://melpa.org/packages/")
     ("gnu" . "https://elpa.gnu.org/packages/")))
 '(package-selected-packages
   '(ag alchemist all-the-icons anzu auto-highlight-symbol coffee-mode
        color-moccur color-theme-modern company-box company-org-block
        dap-mode dart-mode dmacro docker docker-compose-mode
        dockerfile-mode eev exec-path-from-shell find-file-in-project
        flutter git-gutter-fringe google-this guide-key helm-bm
        helm-c-yasnippet helm-emmet js2-mode lsp-tailwindcss lsp-ui
        magit multiple-cursors nyan-mode open-junk-file point-stack
        popup quickrun sequential-command session shell-pop
        switch-window tide ts-comint typescript-mode web-mode
        window-numbering yafolding yasnippet zoom-window))
 '(session-use-package t nil (session))
 '(shell-pop-full-span t)
 '(shell-pop-restore-window-configuration t)
 '(shell-pop-shell-type
   '("ansi-term" "*ansi-term*"
     (lambda nil (ansi-term shell-pop-term-shell))))
 '(shell-pop-term-shell "/bin/zsh")
 '(shell-pop-window-position "bottom")
 '(yas-prompt-functions '(my-yas/prompt)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(lsp-ui-doc-background ((t (:background "black")))))
