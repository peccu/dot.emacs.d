(when (or
       peccu-p
       ;; win-env-p
       ;; wsl-p
       )
  ;;; refresh
  ;; (package-refresh-contents)
  ;;; packages version
  (require-with-install 'find-file-in-project)
  ;;; submodule version
  ;; (add-submodule-to-load-path "git/xxx-mode")
  ;; (require 'xxx-mode)
  ;;; load version
  ;; (load (concat user-emacs-directory "listp/xxx-mode.el"))

  ;; use fd
  (setq ffip-use-rust-fd t)
  ;; activate helm-mode
  (eval-after-load 'helm-mode
    (helm-mode 1))
  )
