(require 'highlight-chars)
;; in highlight-chars-autoloads.el
(set-face-background 'hc-tab "DarkGreen")
(add-hook 'font-lock-mode-hook 'hc-highlight-tabs)
