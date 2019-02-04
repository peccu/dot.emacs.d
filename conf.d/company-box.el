(when (require 'company-box nil t)
  (add-hook 'company-mode-hook 'company-box-mode)
  (setq company-box-icons-elisp
        (list
         (concat (all-the-icons-material "functions") " ")
         (concat (all-the-icons-material "check_circle") " ")
         (concat (all-the-icons-material "stars") " ")
         (concat (all-the-icons-material "format_paint") " ")))
  (setq company-box-icons-unknown (concat (all-the-icons-material "find_in_page") " "))
  (setq company-box-backends-colors nil)
  ;; (global-company-mode)
  )
