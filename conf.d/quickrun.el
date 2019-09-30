(require 'quickrun)
;; quickrun実行後に結果バッファにフォーカスを移さない
(setq quickrun-focus-p nil)
(global-set-key (kbd "M-g M-q") 'fill-paragraph)
(global-set-key (kbd "M-q") 'quickrun)
