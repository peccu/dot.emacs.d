(when (or
       peccu-p
       win-env-p
       wsl-p
       )
  ;;; packages version
  (require-with-install 'howm)
  ;;; submodule version
  ;; (add-submodule-to-load-path "git/xxx-mode")
  ;; (require 'xxx-mode)
  ;;; load version
  ;; (load (concat user-emacs-directory "listp/xxx-mode.el"))

  )
