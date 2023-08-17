(when (or
       peccu-p
       win-env-p
       ;; wsl-p
       )
  (require 'web-mode)
  ;; (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  ;; (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  ;; (add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
  ;; (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  ;; (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  ;; (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  ;; (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.ctp?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.ejs?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.twig?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.svelte?\\'" . web-mode))

  (defun web-mode-hook ()
    "Hooks for Web mode."
    ;; HTML offset indentation
    (setq web-mode-markup-indent-offset 2)
    ;; CSS offset indentation
    (setq web-mode-css-indent-offset 2)
    ;; Script offset indentation (for JavaScript, Java, PHP, etc.)
    (setq web-mode-code-indent-offset 2)
    ;; HTML content(like textarea)
    (setq web-mode-indent-style 2)
    ;; Left padding
    ;; For <style> parts
    (setq web-mode-style-padding 1)
    ;; For <script> parts
    (setq web-mode-script-padding 1)
    ;; For multilines blocks
    (setq web-mode-block-padding 0)
    ;; Comments
    ;; You can choose to comment with server comment instead of client (HTML/CSS/Js) comment with
    ;; テンプレートでテンプレート用のコメントを使うなら2
    (setq web-mode-comment-style 1)
    ;; and more ... http://web-mode.org/

    ;; web-mode-element-next/previousが使いにくいので
    (define-key web-mode-map (kbd "M-C-n") nil)
    (define-key web-mode-map (kbd "M-C-p") nil)
    (define-key web-mode-map (kbd "TAB") #'company-indent-or-complete-common)
    ;; (define-key web-mode-map (kbd "C-n") 'web-mode-tag-match)
    ;; ;; snippet
    ;; (add-to-list 'web-mode-snippets '("mydiv" "<div>" "</div>"))
    ;; ;; Enable / disable features
    ;; ;; Auto-pairing
    ;; (setq web-mode-disable-auto-pairing t)
    ;; ;; CSS colorization
    ;; (setq web-mode-disable-css-colorization t)
    ;; ;; Block face: can be used to set blocks background (see web-mode-block-face)
    ;; (setq web-mode-enable-block-face nil)
    ;; ;; Part face: can be used to set parts background (see web-mode-part-face)
    ;; (setq web-mode-enable-part-face nil)
    ;; ;; Comment keywords (see web-mode-comment-keyword-face)
    ;; (setq web-mode-enable-comment-keywords t)
    ;; ;; Heredoc (cf. PHP strings) fontification (when the identifier is <<<EOTHTML or <<<EOTJAVASCRIPT)
    ;; (setq web-mode-enable-heredoc-fontification t)
    (emmet-mode)
    )
  (add-hook 'web-mode-hook 'web-mode-hook)
  (require 'company)
  (add-hook 'web-mode-hook 'company-mode)

  ;; http://biwakonbu.com/?p=589
  (face-foreground 'font-lock-comment-face)
  ;; web-mode. colors.
  (set-face-attribute 'web-mode-doctype-face nil :foreground "DeepSkyBlue")
  (set-face-attribute 'web-mode-html-tag-face nil :foreground "Cyan")
  (set-face-attribute 'web-mode-html-attr-name-face nil :foreground "LightSteelBlue")
  (set-face-attribute 'web-mode-html-attr-equal-face nil :foreground "#FFFFFF")
  (set-face-attribute 'web-mode-html-attr-value-face nil :foreground "LightSalmon")
  (set-face-attribute 'web-mode-comment-face nil :foreground "OrangeRed")
  ;; (set-face-attribute 'web-mode-server-comment-face nil :foreground "#587F35")

 ;;; web-mode. css colors.
  (set-face-attribute 'web-mode-css-at-rule-face nil :foreground "#DFCF44")
  (set-face-attribute 'web-mode-comment-face nil :foreground "OrangeRed")
  (set-face-attribute 'web-mode-css-selector-face nil :foreground "#DFCF44")
  ;; (set-face-attribute 'web-mode-css-pseudo-class nil :foreground "#DFCF44")
  (set-face-attribute 'web-mode-css-property-name-face nil :foreground "DeepSkyBlue")
  (set-face-attribute 'web-mode-css-string-face nil :foreground "LightSalmon")
  )
