(when (or
       peccu-p
       win-env-p
       ;; wsl-p
       )
  ;; (require 'helm-config)
  ;; (require 'helm-adaptive)
  ;; (require 'helm-aliases)
  ;; (require 'helm-apt)
  ;; (require 'helm-bbdb)
  ;; (require 'helm-bookmark)
  ;; (require 'helm-buffers)
  ;; (require 'helm-color)
  ;; (require 'helm-command)
  ;; (require 'helm-config)
  ;; (require 'helm-dabbrev)
  ;; (require 'helm-elisp-package)
  ;; (require 'helm-elisp)
  ;; (require 'helm-elscreen)
  ;; (require 'helm-emms)
  ;; (require 'helm-eshell)
  ;; (require 'helm-eval)
  ;; (require 'helm-external)
  ;; umm, I don't like this behavior...
  ;; (require 'helm-files)
  ;; ;; use ffap for helm-find-files
  ;; (setq helm-ff-guess-ffap-filenames t)
  ;; (define-key helm-find-files-map (kbd "C-r") 'helm-ff-file-name-history)
  ;; (global-set-key (kbd "C-x C-f") 'helm-find-files)

  ;; (require 'helm-firefox)
  ;; (require 'helm-font)
  ;; (require 'helm-gentoo)
  ;; (require 'helm-grep)
  ;; (require 'helm-help)
  ;; (require 'helm-imenu)
  ;; (require 'helm-info)
  ;; (require 'helm-locate)
  ;; (require 'helm-man)
  ;; (require 'helm-match-plugin)
  ;; (require 'helm-misc)
  ;; (require 'helm-mode)
  ;; (require 'helm-net)
  ;; ; (require 'helm-org)
  ;; ; (require 'helm-pkg)
  ;; (require 'helm-plugin)
  ;; (require 'helm-regexp)
  (require 'helm-ring)
  (global-set-key (kbd "M-y") 'helm-show-kill-ring)
  ;; (require 'helm-semantic)
  ;; (require 'helm-source)
  ;; (require 'helm-sys)
  ;; (require 'helm-tags)
  ;; (require 'helm-utils)
  ;; (require 'helm-w3m)
  ;; (require 'helm-yaoddmuse)
  (require-with-install 'helm)
  ;; <M-f2> twice to launch (in bm.el)
  (require-with-install 'helm-bm)



  (global-set-key (kbd "M-x") 'helm-M-x)
  (global-set-key (kbd "C-x b") 'helm-buffers-list)
  (global-set-key (kbd "C-c h") 'helm-mini)
  (defun resume-helm-or-anything (arg)
    (interactive "p")
    (case arg
      (4 (call-interactively 'anything-resume))
      (t (call-interactively 'helm-resume))))
  (global-set-key (kbd "C-.") 'resume-helm-or-anything)

  ;; ;;; Spotlight (MacOS X desktop search)
  ;; (defvar helm-c-source-mac-spotlight
  ;; (setq helm-c-source-mac-spotlight
  ;;   '((name . "mdfind")
  ;;     (candidates-process
  ;;      . (lambda () (start-process "mdfind-process" nil "mdfind" helm-pattern)))
  ;;     (type . file)
  ;;     (requires-pattern . 3)
  ;;     (delayed))
  ;;   "Source for retrieving files via Spotlight's command line
  ;; utility mdfind.")

  ;; (defun helm-mac-spotlight ()
  ;;   "mac spotlight"
  ;;   (interactive)
  ;;   (helm-other-buffer '(helm-c-source-mac-spotlight)
  ;;                      "*helm spotlight*"))
  ;; (helm-mac-spotlight)
  ;; actionが何かわからん。

  (global-set-key (kbd "M-p") 'helm-browse-project)
  (global-set-key (kbd "M-o") 'helm-occur)
  )
