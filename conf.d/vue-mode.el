(when (or
       peccu-p
       win-env-p
       wsl-p
       )
  ;; Now I back to web-mode
  ;; (require-with-install 'vue-mode)
  ;; (add-submodule-to-load-path "git/vue-mode")
  ;; (require 'vue-mode)
  ;; (require-with-install 'vue-html-mode)
  ;; (add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-mode))
  ;; (add-hook 'vue-mode-hook 'lsp)

  ;; in mmm-mode.el
  ;; https://github.com/AdamNiederer/vue-mode#how-do-i-disable-that-ugly-background-color
  ;; (add-hook 'mmm-mode-hook
  ;;           (lambda ()
  ;;             (set-face-background 'mmm-default-submode-face nil)))

  ;; polymode version (not configured) references
  ;; https://github.com/AdamNiederer/vue-mode/issues/109
  ;; https://www.masteringemacs.org/article/polymode-multiple-major-modes-how-to-use-sql-python-in-one-buffer
  ;; https://superuser.com/questions/20126/is-there-any-good-html-mode-for-emacs/1553876#1553876
  ;; https://polymode.github.io/defining-polymodes/
  ;; https://github.com/emacs-lsp/lsp-mode/issues/424#issuecomment-674955347
  ;; https://github.com/yyoncho/lsp-mode/blob/modes/clients/lsp-eslint.el#L270
  ;; (lsp-register-client
  ;; (make-lsp-client
  ;;  :new-connection ...snip...
  ;;  :activation-fn (lambda (filename &optional _)
  ;;                   (when lsp-eslint-enable
  ;;                     (or (string-match-p (rx (one-or-more anything) "."
  ;;                                             (or "ts" "js" "jsx" "tsx" "html" "vue")eos)
  ;;                                         filename)
  ;;                         (derived-mode-p 'js-mode 'js2-mode 'typescript-mode 'html-mode))))
)
