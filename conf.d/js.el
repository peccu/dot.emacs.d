(when (or
       peccu-p
       ;; win-env-p
       ;; wsl-p
       )
  ;; http://aimstogeek.hatenablog.com/entry/2016/10/25/214101
  (add-hook 'js-mode-hook
            (lambda ()
              (auto-highlight-symbol-mode t)
              (make-local-variable 'js-indent-level)
              (setq js-indent-level 2)))
  )
