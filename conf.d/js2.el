(when (or
       peccu-p
       win-env-p
       ;; wsl-p
       )
  ;; js2-mode
  (require-with-install 'js2-mode)
  (setq js2-basic-offset 2)
  ;; (autoload 'js2-mode "js2-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.jsx\\'" . js2-jsx-mode))

  ;; (require 'flymake-jshint)
  ;; (add-hook 'js2-mode-hook 'flymake-jshint-load)
  ;; (setq js2-mode-show-parse-errors nil)
  ;; (setq js2-mode-show-strict-warnings nil)
  ;; (setq flymake-log-level 3)

  ;; (add-hook 'js2-mode-hook 'flycheck-mode)
  ;; -> flycheck.el

  (add-hook 'js2-mode-hook
            (lambda ()
              (auto-highlight-symbol-mode t)
              (make-local-variable 'js-indent-level)
              (setq js-indent-level 2)
              ;; 関数の引数の色を変える(黒背景だと濃すぎて読めなかった)
              (set-face-foreground 'js2-function-param "light green")
              (set (make-local-variable 'compile-command) "npm test")
              ;; (yas-minor-mode 1)
              ))


  ;; ;; js2-refactor
  ;; (require 'js2-refactor)
  ;; (add-hook 'js2-mode-hook #'js2-refactor-mode)
  ;; (js2r-add-keybindings-with-prefix "C-c C-m")
  ;; ;; guide-key added
  ;; (setq
  ;;  guide-key/guide-key-sequence
  ;;  (append
  ;;   guide-key/guide-key-sequence
  ;;   '(
  ;;     (js2-mode "C-c C-m 3")
  ;;     (js2-mode "C-c C-m a")
  ;;     (js2-mode "C-c C-m b")
  ;;     (js2-mode "C-c C-m c")
  ;;     (js2-mode "C-c C-m d")
  ;;     (js2-mode "C-c C-m e")
  ;;     (js2-mode "C-c C-m i")
  ;;     (js2-mode "C-c C-m k")
  ;;     (js2-mode "C-c C-m l")
  ;;     (js2-mode "C-c C-m r")
  ;;     (js2-mode "C-c C-m s")
  ;;     (js2-mode "C-c C-m t")
  ;;     (js2-mode "C-c C-m u")
  ;;     (js2-mode "C-c C-m v")
  ;;     (js2-mode "C-c C-m w")
  ;;     )))
  )
