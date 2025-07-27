(when (or
       peccu-p
       win-env-p
       wsl-p
       )
  ;; Org babel

  ;; source block completion
  ;; https://github.com/xenodium/company-org-block
  ;; if change from company to corfu, try this
  ;; https://github.com/xenodium/org-block-capf
  (require-with-install 'company-org-block)
  (setq company-org-block-edit-style 'auto) ;; 'auto, 'prompt, or 'inline
  (add-hook 'org-mode-hook
            (lambda ()
              (add-to-list (make-local-variable 'company-backends)
                           'company-org-block)))

  ;; no prompt when evaluate (C-c C-c)
  (setq org-confirm-babel-evaluate nil)

  ;; supporting languages
  ;; (require 'ob-shell)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '(
     (shell . t)
     (js . t)
     ))
  )
