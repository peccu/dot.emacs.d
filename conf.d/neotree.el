(when (or
       ;; peccu-p
       ;; win-env-p
       ;; wsl-p
       )
  (require 'neotree)
  (global-set-key (kbd "<f8>") 'neotree-toggle)
  (setq neo-autorefresh t)
  ;; (setq neo-confirm-delete-directory-recursively 'off-p)
  ;; (setq neo-confirm-kill-buffers-for-files-in-directory 'off-p)
  (setq neo-hidden-regexp-list '("\\.pyc$" "~$" "^#.*#$" "\\.elc$" "\\.o$"))
  ;; (setq neo-keymap-style 'concise)
  ;; (setq neo-show-slash-for-folder nil)
  ;; needs all-the-icons
  (setq neo-theme 'icons)
  ;; (setq neo-toggle-window-keep-p t)
  (setq neo-vc-integration '(face))
  )
