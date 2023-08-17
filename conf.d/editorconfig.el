(when (or
       peccu-p
       ;; win-env-p
       ;; wsl-p
       )
  ;; (setq edconf-exec-path "/usr/local/bin/editorconfig")
  ;; (load "editorconfig")
  (require-with-install 'editorconfig)
  (setq edconf-indentation-alist
        (cons edconf-indentation-alist
              '((vue-mode js-indent-level
                          (web-mode-indent-style . (lambda (size) 2))
                          web-mode-markup-indent-offset
                          web-mode-css-indent-offset
                          web-mode-code-indent-offset
                          web-mode-script-padding
                          web-mode-style-padding
                          css-indent-offset
                          )
                (js-mode js-indent-level)
                (javascript-mode js-indent-level)
                )))
  (editorconfig-mode 1)
  )
