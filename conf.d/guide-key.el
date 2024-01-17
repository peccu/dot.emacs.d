(when (or
       peccu-p
       win-env-p
       ;; wsl-p
       )
  ;; http://rubikitch.com/2014/08/30/guide-key/
  (require-with-install 'guide-key)
  ;; guilde-keyを発動させるプレフィクスキー
  (setq guide-key/guide-key-sequence
        '(;; recursive-key-sequence-flag を t にしたため大半は含まれた状態になっている
          ;; "C-x r"
          ;; "C-x 4"
          ;; "C-x c"
          ;; "C-x v"
          ;; "C-x p"
          ;; "C-x n"
          ;; "C-x @"
          "C-x"
          "C-c"
          "C-z"
          "M-h"
          "M-g"
          "M-s"
          ;; "M-s a"
          ;; "M-s f"
          ;; "C-c !"
          "s-l"
          ;; ;; org-modeではC-c C-xも対象にする
          ;; (org-mode "C-c C-x")
          ;; ;; outline-minor-modeではC-c @も対象にする
          ;; (outline-minor-mode "C-c @")
          ;; ;; js2-modeではC-c C-mを含める(js2-refactor)
          ;; (js2-mode "C-c C-m")
          ;; ;; rst-mode用
          ;; (rst-mode "C-c C-a")          ;adjust section headers, hierarchy
          ;; (rst-mode "C-c C-c")          ;compile
          ;; (rst-mode "C-c C-l")          ;list of various kinds
          ;; (rst-mode "C-c C-r")          ;manipulate the Region
          ;; (rst-mode "C-c C-t")          ;manipulate a Table of contents
          ))

  ;; コマンド名にこれらが含まれている場合はハイライトされる
  (setq guide-key/highlight-command-regexp
        '(
          "rectangle\\|register\\|org-clock"
          ("rst-deprecated-" . font-lock-comment-face)
          ("rst-" . font-lock-type-face)
          ))
  ;; 再帰的にポップアップ対象にする
  (setq guide-key/recursive-key-sequence-flag t)
  ;; 1秒後にポップアップされる(デフォルト)
  ;; つまり1秒以内に操作すればポップアップされずに実行される
  (setq guide-key/idle-delay 1.5)
  ;; 下部にキー一覧を表示させる(デフォルトはright)
  (setq guide-key/popup-window-position 'bottom)
  ;; 文字の大きさを変更する(正の数で大きく、負の数で小さく)
  (setq guide-key/text-scale-amount 2)
  ;; 有効にする
  (guide-key-mode 1)
  )
