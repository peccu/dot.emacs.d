(require 'package)
(prog1 "setup package"
  (custom-set-variables
   '(package-archives '(("org"   . "https://orgmode.org/elpa/")
                        ("melpa" . "https://melpa.org/packages/")
                        ("gnu"   . "https://elpa.gnu.org/packages/"))))

  (when (and (version<  "25" emacs-version)
             (version< emacs-version "26.3"))
    (custom-set-variables
     ;; https://www.reddit.com/r/emacs/comments/cdei4p/failed_to_download_gnu_archive_bad_request/etw48ux
     '(gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3"))
    )
  (package-initialize)
  ;; (package-refresh-contents)
  )
