;;; anything-c-moccurの設定
(require 'helm-c-moccur)
;; カスタマイズ可能変数の設定(M-x customize-group anything-c-moccur でも設定可能)
(setq helm-c-moccur-helm-idle-delay 0.1 ;`helm-idle-delay'
;;       helm-c-moccur-higligt-info-line-flag t ; `helm-c-moccur-dmoccur'などのコマンドでバッファの情報をハイライトする
      helm-c-moccur-enable-auto-look-flag t ; 現在選択中の候補の位置を他のwindowに表示する
      helm-c-moccur-enable-initial-pattern t) ; `helm-c-moccur-occur-by-moccur'の起動時にポイントの位置の単語を初期パターンにする

;; キーバインドの割当(好みに合わせて設定してください)
;; バッファ内検索
(global-set-key (kbd "M-o") 'helm-c-moccur-occur-by-moccur)
;; ディレクトリ
(global-set-key (kbd "C-M-o") 'helm-c-moccur-dmoccur)
(add-hook 'dired-mode-hook ;dired
          '(lambda ()
             (local-set-key (kbd "O") 'helm-c-moccur-dired-do-moccur-by-moccur)))
