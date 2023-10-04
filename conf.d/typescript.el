(when (or
       peccu-p
       win-env-p
       ;; wsl-p
       )
  (require-with-install 'typescript-mode)
  (require-with-install 'ts-comint)
  (require-with-install 'tide)

  (defun setup-tide-mode ()
    (interactive)
    (when  peccu-p
      (tide-setup)
      (tide-hl-identifier-mode +1)
      )
    (flycheck-mode +1)
    ;; (setq flycheck-check-syntax-automatically '(save mode-enabled))
    (eldoc-mode +1)
    (setq js-indent-level 2)
    (setq js2-basic-offset 2)
    (setq typescript-indent-level 2)
    ;; company is an optional dependency. You have to
    ;; install it separately via package-install
    ;; `M-x package-install [ret] company`
    (company-mode +1)
    (auto-highlight-symbol-mode))

  ;; aligns annotation to the right hand side
  (setq company-tooltip-align-annotations t)
  ;; formats the buffer before saving
  (add-hook 'before-save-hook 'tide-format-before-save)
  (add-hook 'typescript-mode-hook #'setup-tide-mode)

  ;; format options
  (setq tide-format-options
        '(
          :indentSize 2
          :insertSpaceAfterFunctionKeywordForAnonymousFunctions t
          :placeOpenBraceOnNewLineForFunctions nil
          ))
  ;; see https://github.com/Microsoft/TypeScript/blob/cc58e2d7eb144f0b2ff89e6a6685fb4deaa24fde/src/server/protocol.d.ts#L421-473 for the full list available options

  ;; Tide can be used along with web-mode to edit tsx files
  (require-with-install 'web-mode)
  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
  (add-hook 'web-mode-hook
            (lambda ()
              (when (string-equal "tsx" (file-name-extension buffer-file-name))
                (setup-tide-mode))))
  )
