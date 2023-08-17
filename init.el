;; -*- mode: emacs-lisp; coding: utf-8 -*-

(defconst my-time-zero (current-time))
;; おそらくEmacs23から定義された変数
(unless (boundp 'user-emacs-directory)
  (setq user-emacs-directory "~/.emacs.d/"))

(load-file (concat user-emacs-directory "lisp/add-to-load-path.el"))
(add-to-load-path "lisp" "mylisp")
;; (add-to-load-path "elpa")
(require 'version-detect)
(message (concat "Your host name is " system-name))

(let ((dir (expand-file-name (concat (getenv "INST_DIR") "/app/emacs/site-lisp"))))
  (if (member dir load-path) nil
    (setq load-path (cons dir load-path))
    (let ((default-directory dir))
      (load (expand-file-name "subdirs.el") t t t))))

;; システムごとの設定を読み込む
(load-file (concat user-emacs-directory "env-detect.el"))
(load-file (concat user-emacs-directory "where-to-load.el"))
(require 'load-config-files)
(load-config-files where-to-load)

;; 初期化にかかった時間を表示する
(require 'time-lag)
(add-hook 'after-init-hook (lambda () (my-time-lag)) t)
(put 'upcase-region 'disabled nil)
