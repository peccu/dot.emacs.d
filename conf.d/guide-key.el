;; http://rubikitch.com/2014/08/30/guide-key/
(require 'guide-key)
;;; guilde-keyを発動させるプレフィクスキー
(setq guide-key/guide-key-sequence
      '("C-x r"
        "C-x 4"
        "C-x c"
        "C-x v"
        "C-x p"
        "C-x n"
        "C-x @"
        "C-x"
        "C-c"
        "C-z"
        "M-h"
        "M-g"
        "M-s"
        "M-s a"
        "M-s f"
        "C-c !"
        ;; org-modeではC-c C-xも対象にする
        (org-mode "C-c C-x")
        ;; outline-minor-modeではC-c @も対象にする
        (outline-minor-mode "C-c @")
        ;; js2-modeではC-c C-mを含める(js2-refactor)
        (js2-mode "C-c C-m")
        ))

;;; コマンド名にこれらが含まれている場合はハイライトされる
(setq guide-key/highlight-command-regexp "rectangle\\|register\\|org-clock")
;;; 1秒後にポップアップされる(デフォルト)
;;; つまり1秒以内に操作すればポップアップされずに実行される
(setq guide-key/idle-delay 1.5)
;;; 下部にキー一覧を表示させる(デフォルトはright)
(setq guide-key/popup-window-position 'bottom)
;;; 文字の大きさを変更する(正の数で大きく、負の数で小さく)
(setq guide-key/text-scale-amount 2)
;;; 有効にする
(guide-key-mode 1)
