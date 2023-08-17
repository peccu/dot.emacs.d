(when (or
       peccu-p
       win-env-p
       wsl-p
       )
  (require-with-install 'anzu)
  (global-anzu-mode +1)

  (set-face-attribute 'anzu-mode-line nil
                      :foreground "red" :weight 'bold)
  ;;                     :foreground "yellow" :weight 'bold)
  ;; (defun my/anzu-update-func (here total)
  ;;   (propertize (format "<%d/%d>" here total)
  ;;               'face '((:foreground "yellow" :weight bold))))
  ;; (setq anzu-mode-line-update-function 'my/update-func)

  (custom-set-variables
   '(anzu-mode-lighter "")
   '(anzu-deactivate-region t)
   '(anzu-search-threshold 1000)
   '(anzu-replace-to-string-separator " => "))

  ;; replace query replace
  (global-set-key (kbd "M-%") 'anzu-query-replace)
  (global-set-key (kbd "C-M-%") 'anzu-query-replace-regexp)
  (global-set-key (kbd "C-x %") 'anzu-replace-at-cursor-thing)
  )
