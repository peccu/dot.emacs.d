(when (or
       peccu-p
       win-env-p
       wsl-p
       )
  (when win-env-p
    ;; for coreos
    (setq rg-executable "/opt/bin/rg")
    )
  (defun rg-command ()
    "Command string for invoking rg."
    (concat (rg-executable)
            " --colors match:fg:red -n"))
  )
