(when (or
       peccu-p
       win-env-p
       ;; wsl-p
       )
  (require 'highlight-chars)
  ;; in highlight-chars-autoloads.el
  (set-face-background 'hc-tab "DarkGreen")
  (add-hook 'font-lock-mode-hook 'hc-highlight-tabs)
  (add-hook 'font-lock-mode-hook 'hc-highlight-trailing-whitespace)

  ;; ---------------- wide space

;;;###autoload
  (defface hc-wide-space '((t (:background "PaleGreen")))
    "*Face for highlighting wide spaces (`　') in Font-Lock mode."
    :group 'Highlight-Characters :group 'faces)

  (defvar hc-highlight-wide-space-p nil
    "Non-nil means font-lock mode highlights wide space characters (`　').")

;;;###autoload
  (defalias 'toggle-highlight-wide-space 'hc-toggle-highlight-wide-space)
;;;###autoload
  (defun hc-toggle-highlight-wide-space (&optional msgp)
    "Toggle highlighting of Wide Space, using face `hc-wide-space'."
    (interactive "p")
    (setq hc-highlight-wide-space-p  (not hc-highlight-wide-space-p))
    (if hc-highlight-wide-space-p
        (add-hook 'font-lock-mode-hook 'hc-highlight-wide-space)
      (remove-hook 'font-lock-mode-hook 'hc-highlight-wide-space)
      (hc-dont-highlight-wide-space))
    (font-lock-mode) (font-lock-mode)
    (when msgp
      (message "Wide Spaces highlighting is now %s" (if hc-highlight-wide-space-p "ON" "OFF"))))

  (defun hc-highlight-wide-space ()
    "Highlight wide spaces (`　')."
    (font-lock-add-keywords nil '(("[　]+" (0 'hc-wide-space t))) 'APPEND))

  (defun hc-dont-highlight-wide-space ()
    "Do not highlight wide spaces (`　')."
    (when (fboundp 'font-lock-remove-keywords)
      (font-lock-remove-keywords nil '(("[　]+" (0 'hc-wide-space t))))))

  (add-hook 'font-lock-mode-hook 'hc-highlight-wide-space)

  ;; ---------------- zero width spaces

;;;###autoload
  (defface hc-zero-width-space '((t (:background "PaleGreen")))
    "*Face for highlighting zero width spaces (`​') in Font-Lock mode."
    :group 'Highlight-Characters :group 'faces)

  (defvar hc-highlight-zero-width-space-p nil
    "Non-nil means font-lock mode highlights zero width spaces characters (`​').")

;;;###autoload
  (defalias 'toggle-highlight-zero-width-space 'hc-toggle-highlight-zero-width-space)
;;;###autoload
  (defun hc-toggle-highlight-zero-width-space (&optional msgp)
    "Toggle highlighting of zero width spaces, using face `hc-zero-width-space'."
    (interactive "p")
    (setq hc-highlight-zero-width-space-p  (not hc-highlight-zero-width-space-p))
    (if hc-highlight-zero-width-space-p
        (add-hook 'font-lock-mode-hook 'hc-highlight-zero-width-space)
      (remove-hook 'font-lock-mode-hook 'hc-highlight-zero-width-space)
      (hc-dont-highlight-zero-width-space))
    (font-lock-mode) (font-lock-mode)
    (when msgp
      (message "zero width spaces highlighting is now %s" (if hc-highlight-zero-width-space-p "ON" "OFF"))))

  (defun hc-highlight-zero-width-space ()
    "Highlight zero width spaces (`​')."
    (font-lock-add-keywords nil '(("[​]+" (0 'hc-zero-width-space t))) 'APPEND))

  (defun hc-dont-highlight-zero-width-space ()
    "Do not highlight zero width spaces (`​')."
    (when (fboundp 'font-lock-remove-keywords)
      (font-lock-remove-keywords nil '(("[​]+" (0 'hc-zero-width-space t))))))

  (add-hook 'font-lock-mode-hook 'hc-highlight-zero-width-space)
  )
