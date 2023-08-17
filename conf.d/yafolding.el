(when (or
       peccu-p
       win-env-p
       ;; wsl-p
       )
  (require-with-install 'yafolding)
  ;; default keymap
  ;; (defvar yafolding-mode-map
  ;;   (let ((map (make-sparse-keymap)))
  ;;     (define-key map (kbd "<C-S-return>") #'yafolding-hide-parent-element)
  ;;     (define-key map (kbd "<C-M-return>") #'yafolding-toggle-all)
  ;;     (define-key map (kbd "<C-return>") #'yafolding-toggle-element)
  ;;     map))
  (add-hook 'prog-mode-hook
            (lambda () (yafolding-mode)))
  ;; (define-key yafolding-mode-map (kbd "<C-S-return>") nil)
  ;; (define-key yafolding-mode-map (kbd "<C-M-return>") nil)
  ;; (define-key yafolding-mode-map (kbd "<C-return>") nil)
  ;; (define-key yafolding-mode-map (kbd "C-c <C-M-return>") 'yafolding-toggle-all)
  ;; (define-key yafolding-mode-map (kbd "C-c <C-S-return>") 'yafolding-hide-parent-element)
  ;; (define-key yafolding-mode-map (kbd "C-c <C-return>") 'yafolding-toggle-element)
  )
