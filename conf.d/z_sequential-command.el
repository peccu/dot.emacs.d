(when (or
       peccu-p
       win-env-p
       wsl-p
       )
  (require-with-install 'sequential-command)
  (require 'sequential-command-config)
  (global-set-key (kbd "C-a") 'seq-home)
  (global-set-key (kbd "C-e") 'seq-end)
  (when (require 'org nil t)
    (define-key org-mode-map (kbd "C-a") 'seq-home)
    (define-key org-mode-map (kbd "C-e") 'seq-end))
  ;; (define-key org-mode-map "\C-a" 'seq-home)
  ;; (define-key org-mode-map "\C-e" 'seq-end)
  ;; (define-key esc-map "u" 'seq-upcase-backward-word)
  ;; (define-key esc-map "c" 'seq-capitalize-backward-word)
  ;; (define-key esc-map "l" 'seq-downcase-backward-word)
  )
