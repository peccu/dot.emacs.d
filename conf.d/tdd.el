(when (or
       peccu-p
       ;; win-env-p
       ;; wsl-p
       )
  (add-submodule-to-load-path "git/emacs-tdd")
  (require 'tdd)
  ;; tdd runs `recompile' when file saved.
  ;; `recompile' exec `compile-command'
  (add-hook 'js2-mode-hook
            (lambda ()
              (set (make-local-variable 'compile-command) "npm test")))
  )
