(when (or
       peccu-p
       ;; win-env-p
       ;; wsl-p
       )
  ;; anything-c-moccurの設定
  (require 'anything-c-moccur)
  ;; カスタマイズ可能変数の設定(M-x customize-group anything-c-moccur でも設定可能)
  (setq
   ;; anything-idle-delay 0.1
   anything-c-moccur-anything-idle-delay 0.1 ;`anything-idle-delay'
   ;; anything-c-moccur-higligt-info-line-flag t ; `anything-c-moccur-dmoccur'などのコマンドでバッファの情報をハイライトする
   anything-c-moccur-enable-auto-look-flag t ; 現在選択中の候補の位置を他のwindowに表示する
   anything-c-moccur-enable-initial-pattern t) ; `anything-c-moccur-occur-by-moccur'の起動時にポイントの位置の単語を初期パターンにする

  ;; キーバインドの割当(好みに合わせて設定してください)
  ;; バッファ内検索
  (global-set-key (kbd "M-o") 'anything-c-moccur-occur-by-moccur)
  ;; ディレクトリ
  (global-set-key (kbd "C-M-o") 'anything-c-moccur-dmoccur)
  (add-hook 'dired-mode-hook ;dired
            '(lambda ()
               (local-set-key (kbd "O") 'anything-c-moccur-dired-do-moccur-by-moccur)))
  )
