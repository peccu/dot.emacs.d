;; version detect
;; http://d.hatena.ne.jp/tomoya/20090807/1249601308
(defun x->bool (elt) (not (not elt)))
;; emacs-version predicates
(setq emacs22-p (string-match "^22" emacs-version)
      emacs23-p (string-match "^23" emacs-version)
      emacs23.0-p (string-match "^23\.0" emacs-version)
      emacs23.1-p (string-match "^23\.1" emacs-version)
      emacs23.2-p (string-match "^23\.2" emacs-version)
      emacs23.3-p (string-match "^23\.3" emacs-version)
      emacs24-p (string-match "^24" emacs-version)
      emacs24.0-p (string-match "^24\.0" emacs-version)
      emacs24.1-p (string-match "^24\.1" emacs-version)
      emacs24.2-p (string-match "^24\.2" emacs-version)
      emacs24.3-p (string-match "^24\.3" emacs-version)
      emacs24.4-p (string-match "^24\.4" emacs-version)
      emacs24.5-p (string-match "^24\.5" emacs-version)
      emacs24.6-p (string-match "^24\.6" emacs-version)
      )

(provide 'version-detect)
