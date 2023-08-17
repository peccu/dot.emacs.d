(when (or
       peccu-p
       win-env-p
       wsl-p
       )
  (require 'auto-highlight-symbol)
  (ahs-set-idle-interval 0.5)
  (global-auto-highlight-symbol-mode t)
  ;; 適用範囲をデフォルトの見えている範囲ではなく buffer 全体に
  ;; https://github.com/shishi/.emacs.d/blob/master/inits/20-auto-highlight-symbol-mode.el
  (custom-set-variables '(ahs-default-range (quote ahs-range-whole-buffer)))

  ;; フックは各モードの設定ファイルに記述
  ;; (add-hook 'coffee-mode-hook 'auto-highlight-symbol-mode)
  )
