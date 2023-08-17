(when (or
       peccu-p
       win-env-p
       ;; wsl-p
       )
  (require-with-install 'quickrun)
  ;; quickrun実行後に結果バッファにフォーカスを移さない
  (setq quickrun-focus-p nil)
  (global-set-key (kbd "M-g M-q") 'fill-paragraph)
  (global-set-key (kbd "M-q") 'quickrun)
  )
