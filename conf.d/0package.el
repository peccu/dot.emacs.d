(require 'package)
(prog1 "setup package"
  (custom-set-variables
   '(package-archives '(
                        ("org"   . "https://orgmode.org/elpa/")
                        ("melpa" . "https://melpa.org/packages/")
                        ("gnu"   . "https://elpa.gnu.org/packages/")
                        ;; ("melpa-stable" . "https://stable.melpa.org/packages/")
                        )))

  (when (and (version<  "25" emacs-version)
             (version< emacs-version "26.3"))
    (custom-set-variables
     ;; https://www.reddit.com/r/emacs/comments/cdei4p/failed_to_download_gnu_archive_bad_request/etw48ux
     '(gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3"))
    )
  (package-initialize)
  ;; https://emacs.stackexchange.com/questions/42072/when-to-call-package-refresh-contents-in-init-el
  (unless package-archive-contents
    (package-refresh-contents))
  )

(defun require-with-install (package)
  (interactive)
  (unless (package-installed-p package)
    (package-install package))
  (require package))

;; for version< emacs-version 29
(require-with-install 'use-package)
