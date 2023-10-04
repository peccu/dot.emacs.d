(when (or
       peccu-p
       win-env-p
       wsl-p
       )
  ;; customize の出力先
  ;; cf.http://www1.ocn.ne.jp/~ruby11/linux/emacs4.html
  (setq custom-file (concat user-emacs-directory where-to-load "/custom-set-output.el"))
  ;; "~/.emacs.d/conf.d/custom-set.el")
  (when window-system
    (scroll-bar-mode -1))
  )
