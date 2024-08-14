;; list available fonts
;; http://xahlee.info/emacs/emacs/emacs_list_and_set_font.html
;; (print (font-family-list))

;; list current frame configuration
;; (print (face-all-attributes 'default))

;; 標準フォントの設定
;; (set-default-font "M+2VM+IPAG circle-12")
;; IME変換時フォントの設定（テストバージョンのみ）
;; (setq w32-ime-font-face "MigMix 1M")
;; (setq w32-ime-font-height 22)
;; 固定等幅フォントの設定
;; (set-face-attribute 'fixed-pitch    nil :family "M+2VM+IPAG circle")
;; 可変幅フォントの設定
;; (set-face-attribute 'variable-pitch nil :family "M+2VM+IPAG circle")

;; find font
(defun my-font-exists (name)
  (car (member name (font-family-list))))
;; (my-font-exists "Hiragino Sans")

;; set base font
(defun my-set-base-font (font-name &rest args)
  (apply 'set-face-attribute 'default nil
         :family font-name
         ;; :height 120
         ;; :weight 'normal
         ;; :width 'normal
         args))

;; default font size (point * 10)
;;
;; WARNING!  Depending on the default font,
;; if the size is not supported very well, the frame will be clipped
;; so that the beginning of the buffer may not be visible correctly.
;; for 4K
(defun my-set-font-size (height)
  (set-face-attribute 'default nil
                      :height height))

;; set rescale
(defun my-set-rescale (ptn scale)
  (add-to-list 'face-font-rescale-alist
               (cons ptn scale)))


;; set jp (japanese-jisx0208) font
;; use specific font for each language charset.
;; if you want to use different font size for specific charset,
;; add :size POINT-SIZE in the font-spec.
;; japanese-jisx0208                          2  94 B
;; japanese-jisx0208-1978                             2  94 @
;; japanese-jisx0212                          2  94 D
;; japanese-jisx0213-1                                2  94 O
;; japanese-jisx0213-2                                2  94 P
;; japanese-jisx0213.2004-1                   2  94 Q
;; jisx0201                                   1 224 none
(defun my-set-jp-font (target-fontset font-name)
  (set-fontset-font target-fontset
                    'japanese-jisx0208
                    (font-spec :family font-name)))

(defun my-set-jp-font-current-frame-fontset (font-name)
  (my-set-jp-font (frame-parameter nil 'font) font-name))

(defun my-set-jp-font-default-fontset (font-name)
  (my-set-jp-font t font-name))

(defun my-set-jp-font-both (font-name)
  (my-set-jp-font-current-frame-fontset font-name)
  (my-set-jp-font-default-fontset font-name))

;; fira code font
;; download firacode nerd font from
;; https://www.nerdfonts.com/font-downloads
;; instruction is here
;; https://github.com/tonsky/FiraCode/wiki/Emacs-instructions
(defun my-find-fira ()
  (or
   (my-font-exists "FiraCode Nerd Font")
   (my-font-exists "Fira Mono")
   (my-font-exists "Fira Code")
   ))

(defun my-fira-setup ()
  ;; setup ligature
  (let ((alist '((33 . ".\\(?:\\(?:==\\|!!\\)\\|[!=]\\)")
                 (35 . ".\\(?:###\\|##\\|_(\\|[#(?[_{]\\)")
                 (36 . ".\\(?:>\\)")
                 (37 . ".\\(?:\\(?:%%\\)\\|%\\)")
                 (38 . ".\\(?:\\(?:&&\\)\\|&\\)")
                 ;; (42 . ".\\(?:\\(?:\\*\\*/\\)\\|\\(?:\\*[*/]\\)\\|[*/>]\\)")
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
  ;; ;; for org (this exclusion does not need anymore with deleting (42 *) definition above)
  ;; (add-hook 'org-mode-hook
  ;;           (lambda ()
  ;;             (setq auto-composition-mode nil)))
  (add-hook 'Buffer-menu-mode-hook
            (lambda ()
              (setq auto-composition-mode nil)))

  ;; in zcolor-theme.el
  ;; ;; overwrite default foreground
  ;; ;; because of FiraCode breaks it
  ;; (set-face-foreground 'default "white")
  ;; (set-face-foreground 'default "black")
  )

;; Try changing font
;; https://github.com/adobe-fonts/source-code-pro
;; https://emacs.stackexchange.com/a/2503/10850
;; (my-set-base-font "Source Code Variable")
;; (my-set-base-font "YuKyokasho Yoko")

;; (my-set-jp-font-both "Hiragino Maru Gothic ProN")
;; (my-set-jp-font-both "Hiragino Mincho ProN")
;; (my-set-jp-font-both "Hiragino Sans")
;; (my-set-jp-font-both "Hiragino Mincho ProN")
;; (my-set-jp-font-both "Hiragino Maru Gothic ProN")
;; (my-set-jp-font-both "Hiragino Kaku Gothic ProN")
;; (my-set-jp-font-both "Osaka"))
;; (my-set-jp-font-both "Hiragino Kaku Gothic ProN")
;; (my-set-jp-font-both "Tsukushi A Round Gothic")
;; (my-set-jp-font-both "YuKyokasho Yoko")
;; (my-set-jp-font-both "Hannotate SC")
;; (my-set-jp-font-both "Songti SC")
;; (my-set-jp-font-both "STFangsong")
;; (my-set-jp-font-both "STKaiti")
;; (my-set-jp-font-both "Weibei SC")
;; (my-set-jp-font-both "Yuanti SC")

(when t
  (my-set-rescale ".*Hiragino.*" 1.1)
  (my-set-rescale ".*Osaka.*" 1.2)
  (my-set-rescale ".*Takao .*" 0.85)
  )

(when (or
       peccu-p
       ;; win-env-p
       ;; wsl-p
       )

  (let ((fira (my-find-fira)))
    (when fira
      (my-set-base-font fira :height 140)
      (my-fira-setup)
      )
    (unless fira
      ;; http://blog.livedoor.jp/tek_nishi/archives/8590439.html
      (my-set-base-font "Menlo" :height 120)))

  (my-set-jp-font-both "Hiragino Kaku Gothic ProN")

  )

(when (or
       ;; peccu-p
       win-env-p
       wsl-p
       )

  (let ((fira (my-find-fira))
        (size (cond
               (win-env-p "-10")
               (wsl-p "-10.5"))))
    (when (and fira (window-system))
      (set-frame-font (concat fira size) t t)
      (add-to-list 'default-frame-alist
                   `(font . ,fira))
      (my-fira-setup)
      )))

(when
    ;; for mac but peccu-p
    ;; should be peccu-p but not configured
    (and (eq system-type 'darwin)
         (not peccu-p))

  (let ((fira (my-find-fira)))
    (when fira
      (my-set-base-font fira :height 140)
      (my-fira-setup)
      ))
  (my-set-font-size 140)

  (my-set-jp-font-both "Hiragino Kaku Gothic ProN")
  )

;; https://qiita.com/Yack-Deculture/items/55fd56949fb08ad8cd54
;; for wslg with pgtk
;; sudo apt install fonts-takao && sudo fc-cache -fv
(when
    ;; should be wsl-p
    (and
     linux-p
     (eq window-system 'pgtk))
  (my-set-jp-font-both "TakaoGothic")
  )
