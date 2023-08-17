(when (or
       peccu-p
       win-env-p
       ;; wsl-p
       )
  (when nil
    ;; 古いEmacsはlinumモードを使う
    (require 'linum)
    ;; バッファ中の行番号表示

    ;; 行番号のフォーマット
    ;; (set-face-attribute 'linum nil :foreground "red" :height 0.8)
    (set-face-attribute 'linum nil :height 0.8)
    (setq linum-format "%4d")
    )
  ;; ;; 特定のメジャーモードでは無効にする
  ;; ;; http://stackoverflow.com/questions/6837511/automatically-disable-a-global-minor-mode-for-a-specific-major-mode
  ;; (define-global-minor-mode my-global-linum-mode linum-mode
  ;;   (lambda ()
  ;;     (when (not (memq major-mode
  ;;                      (list 'org-mode)))
  ;;       (linum-mode))))
  ;; (my-global-linum-mode 1)

  ;; ;; http://d.hatena.ne.jp/daimatz/20120215/1329248780
  ;; (setq linum-delay t)
  ;; (defadvice linum-schedule (around my-linum-schedule () activate)
  ;;   (run-with-idle-timer 0.2 nil #'linum-update-current))

  ;; 組み込み
  (define-global-minor-mode my-global-linum-mode display-line-numbers-mode
    (lambda ()
      (when (not (memq major-mode
                       (list 'org-mode)))
        (display-line-numbers-mode))))
  (my-global-linum-mode 1)
  )
