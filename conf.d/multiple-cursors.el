(when (or
       peccu-p
       win-env-p
       ;; wsl-p
       )
  (require 'multiple-cursors)
  ;; (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
  ;; mc/mark-all-like -this
  (global-set-key (kbd "C-M->") 'mc/mark-all-like-this-dwim)
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "s-<mouse-1>") 'mc/add-cursor-on-click)
  (setq mc/list-file (concat user-emacs-directory "conf.d/multiple-cursors-lists.el"))
  ;; "C-'" while multiple-cursor-mode
  (mc-hide-unmatched-lines-mode -1)
  )
