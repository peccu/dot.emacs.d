(when (or
       peccu-p
       win-env-p
       ;; wsl-p
       )
  (require-with-install 'emmet-mode)
  (add-hook 'sgml-mode-hook 'emmet-mode)
  (add-hook 'nxml-mode-hook 'emmet-mode)
  (add-hook 'css-mode-hook 'emmet-mode)
  ;; インデントをスペース2つに
  (add-hook 'emmet-mode-hook (lambda () (setq emmet-indentation 2)))
  (require 'emmet-mode)
  (eval-after-load "emmet-mode"
    '(progn
       ;; C-j は newline のままにしておく
       (define-key emmet-mode-keymap (kbd "C-j") nil)
       ;; C-returnにも割り当てられている模様
       ;; C-i と Tabの被りを回避
       ;; (keyboard-translate ?\C-i ?\H-i)
       ;; ↑これだと普段のインデントもできなくなるので戻す
       ;; (keyboard-translate ?\C-i ?\C-i)
       ;; ;; C-i で展開
       ;; (define-key emmet-mode-keymap (kbd "H-i") 'emmet-expand-line)
       (define-key emmet-mode-keymap (kbd "C-M-m") 'emmet-expand-line)
       (define-key emmet-mode-keymap (kbd "M-RET") 'emmet-expand-line)
       ;; (define-key emmet-mode-keymap (kbd "C-M-m") nil)
       ;; (define-key emmet-mode-keymap (kbd "\t") 'emmet-expand-line)
       ))
  (setq emmet-preview-default nil)
  )
