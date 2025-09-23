(when (or
       peccu-p
       ;; win-env-p
       ;; wsl-p
       )
  (require-with-install 'lsp-mode)
  (require-with-install 'lsp-ui)
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
  (require-with-install 'dap-mode)

  (when nil
    (defvar lsp-docker-client-packages
      '(lsp-css lsp-clients lsp-bash lsp-go lsp-pylsp lsp-html lsp-typescript
                lsp-terraform lsp-clangd))
    (setq lsp-docker-client-configs
          '((:server-id bash-ls :docker-server-id bashls-docker :server-command "bash-language-server start")
            (:server-id clangd :docker-server-id clangd-docker :server-command "clangd")
            (:server-id css-ls :docker-server-id cssls-docker :server-command "css-languageserver --stdio")
            (:server-id dockerfile-ls :docker-server-id dockerfilels-docker :server-command "docker-langserver --stdio")
            (:server-id gopls :docker-server-id gopls-docker :server-command "gopls")
            (:server-id html-ls :docker-server-id htmls-docker :server-command "html-languageserver --stdio")
            (:server-id pylsp :docker-server-id pyls-docker :server-command "pylsp")
            (:server-id ts-ls :docker-server-id tsls-docker :server-command "typescript-language-server --stdio")))
    (require-with-install 'lsp-docker)
    (lsp-docker-init-clients
     :path-mappings '(
                      ("/Users/peccu/Codes/kiosk" . "/kiosk")
                      ;; ("path-to-projects-you-want-to-use" . "/projects")
                      )
     :client-packages lsp-docker-client-packages
     :client-configs lsp-docker-client-configs)
    )

  ;; ↓ default value
  (setq lsp-enable-indentation t)

  ;; (when win-env-p
  ;;   (require-with-install 'dap-edge))

  ;; (setq lsp-keymap-prefix "s-l")

  (defun my-lsp-install-server (server-id)
    (lsp--require-packages)
    (unless (lsp--server-binary-present? (gethash server-id lsp-clients))
      (lsp-install-server nil server-id)))

  ;; ;; awk
  ;; (unless (lsp--server-binary-present? (gethash 'awkls lsp-clients))
  ;;   (lsp-install-server nil 'awkls))
  ;; (add-hook 'sh-mode-hook #'lsp)

  ;; bash
  (my-lsp-install-server 'bash-ls)
  (add-hook 'sh-mode-hook #'lsp)

  ;; css
  (my-lsp-install-server 'css-ls)
  (add-hook 'css-mode-hook 'lsp)

  ;; dockerfile
  (my-lsp-install-server 'dockerfile-ls)
  (add-hook 'dockerfile-mode-hook 'lsp)
  (add-hook 'docker-compose-mode-hook 'lsp)


  ;; emmet
  (my-lsp-install-server 'emmet-ls)
  (add-hook 'web-mode-hook 'lsp)
  (add-hook 'js2-mode-hook 'lsp)

  ;; html
  (my-lsp-install-server 'html-ls)

  ;; JS, TS
  (my-lsp-install-server 'ts-ls)
  (add-hook 'typescript-mode-hook 'lsp)

  ;; tailwindcss
  (require-with-install 'lsp-tailwindcss)
  (my-lsp-install-server 'tailwindcss)
  ;; launch in .vue
  ;; https://github.com/emacs-lsp/lsp-mode/issues/3513
  (custom-set-variables '(lsp-tailwindcss-add-on-mode t))
  (when (executable-find "rustywind")
    (add-hook 'before-save-hook 'lsp-tailwindcss-rustywind-before-save))

  ;; Vue 3 (web-mode)
  (my-lsp-install-server 'vue-semantic-server)
  (add-hook 'web-mode-hook 'lsp)
  (with-eval-after-load 'lsp-mode
    (add-to-list 'lsp--formatting-indent-alist
                 ;; defined in web-mode.el
                 '(web-mode . web-mode-css-indent-offset)))
  ;; in vue-mode.el
  ;; (add-hook 'vue-mode-hook 'lsp)

;;   (defface company-box-background
;;     '((t :inherit company-tooltip))
;;     "Face used for frame's background.
;; Only the 'background' color is used in this face."
;;     :group 'company-box)

  ;; (defface company-tooltip
  ;;   '((((class color) (min-colors 88) (background light))
  ;;      (:foreground "black" :background "cornsilk"))
  ;;     (((class color) (min-colors 88) (background dark))
  ;;      ;; (:background "gray26")
  ;;      (:foreground "white" :background "black"))
  ;;     (t (:foreground "black" :background "yellow")))
  ;;   ;; https://www.reddit.com/r/emacs/comments/gfq4dk/how_can_i_change_companybox_background_and/
  ;;   ;; '((default :foreground "blue")
  ;;   ;;   (((class color) (min-colors 88) (background light))
  ;;   ;;    (:background "black"))
  ;;   ;;   (((class color) (min-colors 88) (background dark))
  ;;   ;;    (:background "yellow")))
  ;;   "Face used for the tooltip.")

  ;; https://github.com/emacs-lsp/lsp-ui/issues/180
  ;; lsp-ui-doc-background
  t
  )
