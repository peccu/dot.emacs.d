(when (or
       ;; peccu-p
       ;; win-env-p
       ;; wsl-p
       )
  ;; (setq plantuml-jar-path "~/bin/plantuml.jar")
  (setq plantuml-jar-path nil)
  (add-to-list 'auto-mode-alist '("\\.plantuml\\'" . plantuml-mode))
  ;; M-x plantuml-complete-symbol
  ;; M-x plantuml-preview
  ;; C-c C-c  plantuml-preview: renders a PlantUML diagram from the current buffer in the best supported format
  ;; C-u C-c C-c  plantuml-preview in other window
  ;; C-u C-u C-c C-c plantuml-preview in other frame
  (add-to-list
   'org-src-lang-modes '("plantuml" . plantuml))
  )
