(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
;;              '("melpa" . "https://elpa.zilongshanren.com/"))
;;              '("melpa" . "https://melpa.org/packages/"))
;; (add-to-list 'package-archives
;;              '("marmalade" . "http://marmalade-repo.org/packages/"))
;; (add-to-list 'package-archives
;;              '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(package-initialize t)
;; (setq package-archives '(("marmalade" . "http://marmalade-repo.org/packages/")
;;                          ("gnu" . "http://elpa.gnu.org/packages/")
;;                          ;;  ("melpa" . "https://elpa.zilongshanren.com/")
;;                          ;; ("melpa" . "mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
;;                          ("melpa" . "https://melpa.org/packages/")
;;                          ;; ("melpa-stable" . "https://stable.melpa.org/packages/")
;;                          ))
