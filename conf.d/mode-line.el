;; 行番号の表示
(line-number-mode t)

;; 列番号の表示
(column-number-mode t)

;; 時刻の表示
(require 'time)
(setq display-time-24hr-format t)
(setq display-time-string-forms '(month "/" day " " 24-hours ":" minutes " "))
(display-time-mode t)

;; cp932エンコード時の表示を「P」とする
(coding-system-put 'cp932 :mnemonic ?P)
(coding-system-put 'cp932-dos :mnemonic ?P)
(coding-system-put 'cp932-unix :mnemonic ?P)
(coding-system-put 'cp932-mac :mnemonic ?P)

(add-hook 'after-init-hook
          (lambda ()
            (setq-default mode-line-format
                          '("%e"
                            ;; window-numbering-modeにて定義
                            (:eval
                             (when (and (boundp 'window-numbering-mode) window-numbering-mode)
                                 (window-numbering-get-number-string)))
                            mode-line-front-space
                            ;; count-lines-and-chars.elにて定義
                            (:eval (count-lines-and-chars))
                            mode-line-mule-info
                            mode-line-client
                            mode-line-modified
                            mode-line-remote
                            mode-line-frame-identification
                            mode-line-buffer-identification
                            mode-line-position
                            (vc-mode vc-mode)
                            ;; " "
                            ;; org-clock-inでフレームタイトルに設定できたので、モード名はモードラインに戻す
                            mode-line-modes
                            mode-line-misc-info
                            mode-line-end-spaces))))
;; (delete 'mode-line-modes mode-line-format)
;; (delete '(:eval (my/update-git-branch-mode-line)) mode-line-format)

;; (memq 'mode-line-modes mode-line-format)
;; (let (
;;       (cell '(hoge fuga piyo))
;;       (cell2 '(a b c))
;;       )
;;   (delete 'fuga cell)
;;   cell)

;; (let ((cell (or (memq 'mode-line-position mode-line-format)
;;                 (memq 'mode-line-buffer-identification mode-line-format)))
;;       (newcdr '(:eval (my/update-git-branch-mode-line))))
;;   (unless (member newcdr mode-line-format)
;;     (setcdr cell (cons newcdr (cdr cell)))))

;; (defun my/update-git-branch-mode-line ()
;;   (let* ((branch (replace-regexp-in-string
;;                   "[\r\n]+\\'" ""
;;                   (shell-command-to-string "git symbolic-ref -q HEAD")))
;;          (mode-line-str (if (string-match "^refs/heads/" branch)
;;                             (cond
;;                              ((string-match "^refs/heads/feature/" branch)
;;                               (format "[f/%s]" (substring branch 19)))
;;                              ((string-match "^refs/heads/release/" branch)
;;                               (format "[r/%s]" (substring branch 19)))
;;                              ((string-match "^refs/heads/hotfix/" branch)
;;                               (format "[h/%s]" (substring branch 18)))
;;                              (t
;;                               (format "[%s]" (substring branch 11))))
;;                           "[Not Repo]")))
;;     (propertize mode-line-str
;;                 'face '((:foreground "Dark green" :weight bold)))))

;; ;; buffer name
;; ;; mode-line-buffer-identification
;; (#("%12b" 0 4
;;    (local-map
;;     (keymap
;;      (header-line keymap
;;                   (mouse-3 . mode-line-next-buffer)
;;                   (down-mouse-3 . ignore)
;;                   (mouse-1 . mode-line-previous-buffer)
;;                   (down-mouse-1 . ignore))
;;      (mode-line keymap
;;                 (mouse-3 . mode-line-next-buffer)
;;                 (mouse-1 . mode-line-previous-buffer)))
;;     mouse-face
;;     mode-line-highlight
;;     help-echo "Buffer name\nmouse-1: Previous buffer\nmouse-3: Next buffer"
;;     face
;;     mode-line-buffer-id)))

;; face
;; https://dev.to/gonsie/beautifying-the-mode-line-3k10
(set-face-attribute 'mode-line nil
                    :background "#00ddff"
                    )

;; /Applications/Emacs.app/Contents/Resources/lisp/faces.el.gz
;; (defface mode-line
;;   '((((class color) (min-colors 88))
;;      :box (:line-width -1 :style released-button)
;;      :background "grey75" :foreground "black")
;;     (t
;;      :inverse-video t))
;;   "Basic mode line face for selected window."
;;   :version "21.1"
;;   :group 'mode-line-faces
;;   :group 'basic-faces)

;; (defface mode-line-inactive
;;   '((default
;;      :inherit mode-line)
;;     (((class color) (min-colors 88) (background light))
;;      :weight light
;;      :box (:line-width -1 :color "grey75" :style nil)
;;      :foreground "grey20" :background "grey90")
;;     (((class color) (min-colors 88) (background dark) )
;;      :weight light
;;      :box (:line-width -1 :color "grey40" :style nil)
;;      :foreground "grey80" :background "grey30"))
;;   "Basic mode line face for non-selected windows."
;;   :version "22.1"
;;   :group 'mode-line-faces
;;   :group 'basic-faces)
