;; ;; 標準フォントの設定
;; ;; (set-default-font "M+2VM+IPAG circle-12")

;; ;; IME変換時フォントの設定（テストバージョンのみ）
;; ;; (setq w32-ime-font-face "MigMix 1M")
;; ;; (setq w32-ime-font-height 22)

;; ;; 固定等幅フォントの設定
;; ;; (set-face-attribute 'fixed-pitch    nil :family "M+2VM+IPAG circle")

;; ;; 可変幅フォントの設定
;; ;; (set-face-attribute 'variable-pitch nil :family "M+2VM+IPAG circle")

;; ;; http://blog.livedoor.jp/tek_nishi/archives/8590439.html
;; ;; (set-face-attribute 'default nil :family "Menlo" :height 120)
;; ;; (set-face-attribute 'default nil :family "Fira Code" :height 120)
;; (set-fontset-font (frame-parameter nil 'font)
;;                   'japanese-jisx0208
;;                   ;; (font-spec :family "Hiragino Maru Gothic ProN"))
;;                   (font-spec :family "Hiragino Mincho ProN"))
;;                   ;; (font-spec :family "Hiragino Kaku Gothic ProN"))
;; (add-to-list 'face-font-rescale-alist
;;              ;; '(".*Hiragino Maru Gothic ProN.*" . 1.2))
;;              '(".*Hiragino Mincho ProN.*" . 1.2))
;;              ;; '(".*Hiragino Kaku Gothic ProN.*" . 1.2))

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

;; ;; https://github.com/adobe-fonts/source-code-pro
;; ;; https://emacs.stackexchange.com/a/2503/10850
;; (set-face-attribute 'default nil
;;                     :family "Source Code Variable"
;;                     :height 130
;;                     :weight 'normal
;;                     :width 'normal)

(when (eq system-type 'darwin)

  (face-all-attributes 'default)

  ;; default Latin font (e.g. Consolas)
  (set-face-attribute 'default nil :family "Fira Code")
  ;; (set-face-attribute 'default nil :family "YuKyokasho Yoko")

  ;; default font size (point * 10)
  ;;
  ;; WARNING!  Depending on the default font,
  ;; if the size is not supported very well, the frame will be clipped
  ;; so that the beginning of the buffer may not be visible correctly.
  (set-face-attribute 'default nil :height 120)

  (add-to-list 'face-font-rescale-alist
               '(".*Osaka.*" . 1.2))

  ;; use specific font for Korean charset.
  ;; if you want to use different font size for specific charset,
  ;; add :size POINT-SIZE in the font-spec.
  ;; japanese-jisx0208	                        2  94 B
  ;; japanese-jisx0208-1978	                        2  94 @
  ;; japanese-jisx0212	                        2  94 D
  ;; japanese-jisx0213-1	                        2  94 O
  ;; japanese-jisx0213-2	                        2  94 P
  ;; japanese-jisx0213.2004-1	                2  94 Q
  ;; jisx0201	                                1 224 none
  ;; (set-fontset-font t 'japanese-jisx0208 (font-spec :name "Hiragino Mincho ProN" :size 11))
  ;; (set-fontset-font t 'japanese-jisx0208 (font-spec :name "Hiragino Maru Gothic ProN" :size 11))
  ;; (set-fontset-font t 'japanese-jisx0208 (font-spec :name "Hiragino Kaku Gothic ProN" :size 11))
  (set-fontset-font t 'japanese-jisx0208 (font-spec :name "Osaka" :size 12))
  ;; (set-fontset-font t 'japanese-jisx0208 (font-spec :name "Hiragino Kaku Gothic ProN" :size 12))
  ;; (set-fontset-font t 'japanese-jisx0208 (font-spec :name "Tsukushi A Round Gothic" :size 14))
  ;; (set-fontset-font t 'ascii (font-spec :name "Fira Code" :size 18))
  ;; (set-fontset-font t 'japanese-jisx0208 (font-spec :name "YuKyokasho Yoko" :size 14))

  ;; (set-fontset-font t 'japanese-jisx0208 (font-spec :name "Hannotate SC" :size 11))
  ;; (set-fontset-font t 'japanese-jisx0208 (font-spec :name "Songti SC" :size 12))
  ;; (set-fontset-font t 'japanese-jisx0208 (font-spec :name "STFangsong" :size 12))
  ;; (set-fontset-font t 'japanese-jisx0208 (font-spec :name "STKaiti" :size 13))
  ;; (set-fontset-font t 'japanese-jisx0208 (font-spec :name "Weibei SC" :size 13))
  ;; (set-fontset-font t 'japanese-jisx0208 (font-spec :name "Yuanti SC" :size 13))

  ;; you may want to add different for other charset in this way.
  )
