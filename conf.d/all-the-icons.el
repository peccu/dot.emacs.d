(require 'all-the-icons)
;; M-x all-the-icons-install-fonts
(when (require 'all-the-icons-dired nil t)
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))
