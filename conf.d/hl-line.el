(when (or
       peccu-p
       win-env-p
       wsl-p
       )
  ;; http://murakan.cocolog-nifty.com/blog/2009/01/emacs-tips-1d45.html
  ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; 編集行を目立たせる（現在行をハイライト表示する）
  ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; (defface hlline-face
  ;;   '((((class color)
  ;;       (background dark))
  ;;      (:background "dark slate gray"))
  ;;     (((class color)
  ;;       (background light))
  ;;      (:background "ForestGreen"))
  ;;     (t
  ;;      ()))
  ;;   "*Face used by hl-line.")
  ;; (setq hl-line-face 'hlline-face)
  (defface hlline-face
    '((((class color)
        (background dark))
       (:background "DodgerBlue3" :extend t))
      (((class color)
        (background light))
       (:background "dark gray" :extend t))
      (t (:bold t)))
    "*Face used by hl-line.")
  ;; (set-face-background 'hlline-face "SkyBlue3")
  (setq hl-line-face 'hlline-face)
  ;; (setq hl-line-face 'underline) ; 下線
  (global-hl-line-mode)
  ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; ↓あんまり効果なかった
  ;; ;; http://rubikitch.com/2015/05/14/global-hl-line-mode-timer/
  ;; (defun global-hl-line-timer-function ()
  ;;   (global-hl-line-unhighlight-all)
  ;;   (let ((global-hl-line-mode t))
  ;;     (global-hl-line-highlight)))
  ;; (setq global-hl-line-timer
  ;;       (run-with-idle-timer 0.1 t 'global-hl-line-timer-function))
  ;; ;; (cancel-timer global-hl-line-timer)
  )
