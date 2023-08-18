;; -*- mode: emacs-lisp; coding: utf-8 -*-
;; after 27, this file should be loaded before GUI setup

;; env detection
(load-file (concat user-emacs-directory "lisp/version-detect.el"))
(load-file (concat user-emacs-directory "env-detect.el"))

(setq package-user-dir (concat user-emacs-directory "elpa-" emacs-version "-" emacs-os))

;; https://uwabami.github.io/cc-env/Emacs.html
(push '(vertical-scroll-bars . nil) default-frame-alist)
(push '(menu-bar-lines       . nil) default-frame-alist)
(push '(tool-bar-lines       . nil) default-frame-alist)
(push '(scroll-bar-mode      . nil) default-frame-alist)
(push '(blink-cursor-mode    . nil) default-frame-alist)
(push '(column-number-mode   . nil) default-frame-alist)
;; (setq load-prefer-newer noninteractive)
;; (setq frame-inhibit-implied-resize t)
;; (setq site-run-file nil)
;; (setq window-divider-default-right-width 3)
;; (setq package-enable-at-startup nil)
(provide 'early-init)
