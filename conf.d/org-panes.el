(when (or
       ;; peccu-p
       ;; win-env-p
       ;; wsl-p
       )
  (eval-after-load "org"
    '(progn
       (add-submodule-to-load-path "git/org-panes")
       (require 'org-panes)
       (setq org-panes-overview-depth 2)
       (setq org-panes-contents-depth 3)
       ))
  )
