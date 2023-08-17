(when (or
       ;; peccu-p
       win-env-p
       wsl-p
       )
  ;; (add-to-list 'load-path "~/.emacs.d//git/tramp/lisp")
  (require 'tramp)

  (add-to-list 'tramp-remote-process-environment
               (format "DISPLAY=%s" (getenv "DISPLAY")))

  (add-to-list 'tramp-remote-process-environment
               "HISTFILE=/dev/null")
  ;; (setq tramp-remote-process-environment
  ;;       `("TMOUT=0" "LC_CTYPE=''"
  ;;         ,(format "TERM=%s" tramp-terminal-type)
  ;;         ,(format "INSIDE_EMACS='%s,tramp:%s'" emacs-version tramp-version)
  ;;         "CDPATH=" "HISTORY=" "MAIL=" "MAILCHECK=" "MAILPATH=" "PAGER=cat"
  ;;         "autocorrect=" "correct="))

  ;; (defadvice tramp-handle-vc-registered (around tramp-handle-vc-registered-around activate)
  ;;   (let ((vc-handled-backends '(Git))) ad-do-it))
  )
