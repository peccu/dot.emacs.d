(when (or
       ;; peccu-p
       win-env-p
       ;; wsl-p
       )
  ;; remove hook
  ;; http://stackoverflow.com/questions/5748814/how-does-one-disable-vc-git-in-emacs
  (eval-after-load "vc" '(remove-hook 'find-file-hooks 'vc-find-file-hook))
  (setq vc-handled-backends nil)
  )
