(when (or
       ;; peccu-p
       win-env-p
       ;; wsl-p
       )
  ;; customize の出力先
  ;; cf.http://www1.ocn.ne.jp/~ruby11/linux/emacs4.html
  (setq custom-file (concat user-emacs-directory where-to-load "/custom-set.el"))
  ;; "~/.emacs.d/conf.d/custom-set.el")
  (when window-system
    (scroll-bar-mode -1))
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
   '(package-selected-packages
     '(
       ag
       alchemist
       all-the-icons
       anzu
       auto-highlight-symbol
       blackout
       bm
       color-theme-modern
       company
       company-box
       docker
       docker-compose-mode
       dockerfile-mode
       eev
       el-get
       elixir-mode
       emmet-mode
       exec-path-from-shell
       find-file-in-project
       git-gutter-fringe
       go-mode
       google-this
       guide-key
       helm-ag
       helm-c-yasnippet
       helm-files
       helm-swoop
       hydra
       js2-mode
       leaf
       magit
       magit-section
       markdown-mode
       markdown-preview-eww
       markdown-preview-mode
       markdown-toc
       multiple-cursors
       nyan-mode
       open-junk-file
       powershell
       quickrun
       rust-mode
       sequential-command
       session
       switch-window
       tide
       ts-comint
       typescript-mode
       vdiff
       web-mode
       window-numbering
       yafolding
       yasnippet
       zoom-window
       ))
   '(session-use-package t nil (session))
   '(yas-prompt-functions '(my-yas/prompt)))
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   )
  )
