(when (or
       peccu-p
       win-env-p
       ;; wsl-p
       )
  (require-with-install 'helm-ag)
  (require-with-install 'rg)

  ;; (setq helm-ag-base-command "ag --nocolor --nogroup --ignore-case")
  ;; (setq helm-ag-base-command "grep -rin")
  ;; (setq helm-ag-base-command "csearch -n")
  ;; (setq helm-ag-base-command "pt --nocolor --nogroup")
  (setq helm-ag-base-command "rg --vimgrep --no-heading")
  ;; (setq helm-ag-command-option "--all-text")
  (setq helm-ag-insert-at-point 'symbol)

  (defun ag-command (arg)
    "call helm-do-ag or ag (use C-u)"
    (interactive "p")
    (case arg
      (4 (call-interactively 'ag))
      (t (call-interactively 'helm-do-ag))
      ))
  (global-set-key (kbd "M-g a") 'ag-command)
  ;; (global-set-key (kbd "M-g M-a") 'ag)
  (global-set-key (kbd "M-g M-a") 'rg)
  (global-set-key (kbd "M-g M-p") 'helm-do-ag-project-root)
  ;; https://github.com/syohex/emacs-helm-ag/issues/98
  (setq helm-ag-use-agignore t)
  )
