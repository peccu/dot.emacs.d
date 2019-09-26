;; 標準フォントの設定
;; (set-default-font "M+2VM+IPAG circle-12")

;; IME変換時フォントの設定（テストバージョンのみ）
;; (setq w32-ime-font-face "MigMix 1M")
;; (setq w32-ime-font-height 22)

;; 固定等幅フォントの設定
;; (set-face-attribute 'fixed-pitch    nil :family "M+2VM+IPAG circle")

;; 可変幅フォントの設定
;; (set-face-attribute 'variable-pitch nil :family "M+2VM+IPAG circle")

;; http://blog.livedoor.jp/tek_nishi/archives/8590439.html
;; (set-face-attribute 'default nil :family "Menlo" :height 120)
;; (set-face-attribute 'default nil :family "Fira Code" :height 120)
(set-fontset-font (frame-parameter nil 'font)
                  'japanese-jisx0208
                  (font-spec :family "Hiragino Kaku Gothic ProN"))
(add-to-list 'face-font-rescale-alist
             '(".*Hiragino Kaku Gothic ProN.*" . 1.2))

;; https://github.com/tonsky/FiraCode/wiki/Emacs-instructions
(when (window-system)
  (set-frame-font "Fira Code"))
(let ((alist '((33 . ".\\(?:\\(?:==\\|!!\\)\\|[!=]\\)")
               (35 . ".\\(?:###\\|##\\|_(\\|[#(?[_{]\\)")
               (36 . ".\\(?:>\\)")
               (37 . ".\\(?:\\(?:%%\\)\\|%\\)")
               (38 . ".\\(?:\\(?:&&\\)\\|&\\)")
               (42 . ".\\(?:\\(?:\\*\\*/\\)\\|\\(?:\\*[*/]\\)\\|[*/>]\\)")
               (43 . ".\\(?:\\(?:\\+\\+\\)\\|[+>]\\)")
               (45 . ".\\(?:\\(?:-[>-]\\|<<\\|>>\\)\\|[<>}~-]\\)")
               (46 . ".\\(?:\\(?:\\.[.<]\\)\\|[.=-]\\)")
               (47 . ".\\(?:\\(?:\\*\\*\\|//\\|==\\)\\|[*/=>]\\)")
               (48 . ".\\(?:x[a-zA-Z]\\)")
               (58 . ".\\(?:::\\|[:=]\\)")
               (59 . ".\\(?:;;\\|;\\)")
               (60 . ".\\(?:\\(?:!--\\)\\|\\(?:~~\\|->\\|\\$>\\|\\*>\\|\\+>\\|--\\|<[<=-]\\|=[<=>]\\||>\\)\\|[*$+~/<=>|-]\\)")
               (61 . ".\\(?:\\(?:/=\\|:=\\|<<\\|=[=>]\\|>>\\)\\|[<=>~]\\)")
               (62 . ".\\(?:\\(?:=>\\|>[=>-]\\)\\|[=>-]\\)")
               (63 . ".\\(?:\\(\\?\\?\\)\\|[:=?]\\)")
               (91 . ".\\(?:]\\)")
               (92 . ".\\(?:\\(?:\\\\\\\\\\)\\|\\\\\\)")
               (94 . ".\\(?:=\\)")
               (119 . ".\\(?:ww\\)")
               (123 . ".\\(?:-\\)")
               (124 . ".\\(?:\\(?:|[=|]\\)\\|[=>|]\\)")
               (126 . ".\\(?:~>\\|~~\\|[>=@~-]\\)")
               )
             ))
  (dolist (char-regexp alist)
    (set-char-table-range composition-function-table (car char-regexp)
                          `([,(cdr char-regexp) 0 font-shape-gstring]))))
(add-hook 'helm-major-mode-hook
          (lambda ()
            (setq auto-composition-mode nil)))
;; for Mew
(add-hook 'mew-summary-mode-hook
          (lambda ()
            (setq auto-composition-mode nil)))
(add-hook 'mew-virtual-mode-hook
          (lambda ()
            (setq auto-composition-mode nil)))
(add-hook 'mew-header-mode-hook
          (lambda ()
            (setq auto-composition-mode nil)))
(add-hook 'mew-draft-mode-hook
          (lambda ()
            (setq auto-composition-mode nil)))
(add-hook 'mew-message-mode-hook
          (lambda ()
            (setq auto-composition-mode nil)))

;; https://github.com/adobe-fonts/source-code-pro
;; https://emacs.stackexchange.com/a/2503/10850
(set-face-attribute 'default nil
                    :family "Source Code Variable"
                    :height 130
                    :weight 'normal
                    :width 'normal)
