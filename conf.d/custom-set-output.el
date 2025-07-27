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
   '(ag alchemist all-the-icons anzu auto-highlight-symbol blackout bm color-moccur color-theme-modern company company-box company-org-block corfu dart-mode dmacro docker docker-compose-mode dockerfile-mode editorconfig eev el-get elixir-mode emmet-mode ess exec-path-from-shell find-file-in-project flutter git-gutter-fringe go-mode google-this guide-key helm-ag helm-c-yasnippet helm-emmet helm-files helm-swoop hydra js2-mode leaf lsp-mode magit magit-section markdown-mode markdown-preview-eww markdown-preview-mode markdown-toc multiple-cursors nyan-mode open-junk-file powershell quickrun rg rust-mode sequential-command session switch-window tide ts-comint typescript-mode use-package vdiff web-mode window-numbering yafolding yasnippet zoom-window))
 '(session-use-package t nil (session))
 '(shell-pop-full-span t)
 '(shell-pop-restore-window-configuration t)
 '(shell-pop-shell-type
   '("ansi-term" "*ansi-term*"
     (lambda nil
       (ansi-term shell-pop-term-shell))))
 '(shell-pop-term-shell "/bin/zsh")
 '(shell-pop-window-position "bottom")
 '(yas-prompt-functions '(my-yas/prompt)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(lsp-ui-doc-background ((t (:background "black")))))
