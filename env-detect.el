;; -*- mode: emacs-lisp; coding: utf-8 -*-
;; system-type predicates
(setq darwin-p  (eq system-type 'darwin)
      ns-p      (eq window-system 'ns)
      carbon-p  (eq window-system 'mac)
      linux-p   (eq system-type 'gnu/linux)
      colinux-p (when linux-p
                  (let ((file "/proc/modules"))
                    (and
                     (file-readable-p file)
                     (x->bool
                      (with-temp-buffer
                        (insert-file-contents file)
                        (goto-char (point-min))
                        (re-search-forward "^cofuse\.+" nil t))))))
      cygwin-p  (eq system-type 'cygwin)
      nt-p      (eq system-type 'windows-nt)
      meadow-p  (featurep 'meadow)
      windows-p (or cygwin-p nt-p meadow-p))

(setq emacs-os (cond
                  ((or darwin-p carbon-p) "mac")
                  ((or windows-p) "win")
                  (t "")
                  ))

(setq
 peccu-p         (string-match "^peccu\\(.+\\)*$" system-name)
 win-env-p      (or
                 (string-match "^SOME-HOSTNAME$" system-name)
                 )
 wsl-p           (or
                  (and (getenv "TOOLTYPE") (string-match "tool" (getenv "TOOLTYPE")))
                  (getenv "WSL2_GUI_APPS_ENABLED")
                  (getenv "WAYLAND_DISPLAY")
                  )
 )
