;; -*- mode: emacs-lisp; coding: utf-8 -*-

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(defconst my-time-zero (current-time))
;; おそらくEmacs23から定義された変数
(unless (boundp 'user-emacs-directory)
  (setq user-emacs-directory "~/.emacs.d/"))

(load-file (concat user-emacs-directory "lisp/add-to-load-path.el"))
(add-to-load-path "lisp" "mylisp" "elpa")
(require 'version-detect)
(message (concat "Your host name is " system-name))

(let ((dir (expand-file-name (concat (getenv "INST_DIR") "/app/emacs/site-lisp"))))
  (if (member dir load-path) nil
    (setq load-path (cons dir load-path))
    (let ((default-directory dir))
      (load (expand-file-name "subdirs.el") t t t))))

;; システムごとの設定を読み込む
(require 'load-config-files)
(load-file (concat user-emacs-directory "where-to-load.el"))
(load-config-files where-to-load)

;; 初期化にかかった時間を表示する
(require 'time-lag)
(add-hook 'after-init-hook (lambda () (my-time-lag)) t)
(put 'upcase-region 'disabled nil)
