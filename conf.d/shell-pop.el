(when (or
       peccu-p
       ;; win-env-p
       ;; wsl-p
       )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;; '(shell-pop-default-directory "/Users/")
 '(shell-pop-shell-type (quote ("ansi-term" "*ansi-term*" (lambda nil (ansi-term shell-pop-term-shell)))))
 '(shell-pop-term-shell "/bin/zsh")
 ;; '(shell-pop-universal-key "C-t")
 ;; '(shell-pop-window-size 30)
 '(shell-pop-full-span t)
 '(shell-pop-window-position "bottom")
 ;; '(shell-pop-autocd-to-working-dir t)
 '(shell-pop-restore-window-configuration t)
 ;; '(shell-pop-cleanup-buffer-at-process-exit t)
 )
  (require-with-install 'shell-pop)
  ;; (require 'term-toggle)
  (define-key global-map (kbd "M-`") #'shell-pop)
  (define-key term-raw-map (kbd "M-`") #'shell-pop)
  )
