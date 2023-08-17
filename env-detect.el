;; -*- mode: emacs-lisp; coding: utf-8 -*-
(setq
 peccu-p         (string-match "^peccu\\(\\..+\\)*$" system-name)
 win-env-p      (or
                 (string-match "^SOME-HOSTNAME$" system-name)
                 )
 wsl-p           (or
                  (and (getenv "TOOLTYPE") (string-match "tool" (getenv "TOOLTYPE")))
                  (getenv "WSL2_GUI_APPS_ENABLED")
                  (getenv "WAYLAND_DISPLAY")
                  )
 )
