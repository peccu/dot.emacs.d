(when (or
       peccu-p
       win-env-p
       wsl-p
       )
  (require 'highlight-chars)
  ;; in highlight-chars-autoloads.el
  (set-face-background 'hc-tab "DarkGreen")
  (add-hook 'font-lock-mode-hook 'hc-highlight-tabs)
  (add-hook 'font-lock-mode-hook 'hc-highlight-trailing-whitespace)

  ;; set my highlight target chars
  (setq my-hc-highlight-chars '(
                                ;; wide space
                                ;; (U+3000 : char code 12288)
                                "　"
                                ;; zero width spaces
                                ;; (U+200b : char code 8203)
                                "​"
                                ;; &nbsp; spaces
                                ;; (U+00A0 : char code 160)
                                " "
                                ))
  ;; set face if you want to change
  (defface my-hc-highlight-face '((t (:background "PaleGreen")))
    "*Face for highlighting chars in `my-hc-highlight-chars' in Font-Lock mode."
    :group 'Highlight-Characters :group 'faces)

  ;; enable highlight
  ;; this add hook to font-lock-mode-hook
  ;; (hc-highlight-chars my-hc-highlight-chars 'my-hc-highlight-face nil t)
  (hc-highlight-chars my-hc-highlight-chars 'hc-other-char nil t) ;HotPink
  ;; disable highlight = remove-hook
  ;; (hc-highlight-chars my-hc-highlight-chars 'my-hc-highlight-face t t)
  ;; (hc-highlight-chars my-hc-highlight-chars 'hc-other-char t t)
  )
