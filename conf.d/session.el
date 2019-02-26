;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; session
;; ファイルの履歴や，カーソルの位置などを覚えておく
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'session)
(add-hook 'after-init-hook 'session-initialize)
;; ファイル保存時じゃなく，閉じたときに状態を保存する
(setq session-undo-check -1)

;; ファイルの履歴の件数を30(default)からinfiniteへ．
;; (session.elの設定ではないがここに記述する)
(setq history-length t)

;; 保存先
(setq session-save-file (concat user-emacs-directory ".session"))
