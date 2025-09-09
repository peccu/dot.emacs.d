(when (or
       peccu-p
       ;; win-env-p
       ;; wsl-p
       )
  ;; packages version
  (require-with-install 'gptel)
  ;; submodule version
  (add-submodule-to-load-path "git/vscode-cp-proxy")
  (require 'vscode-cp-proxy)

  (setq gptel-model "claude-sonnet-4")
  (setq gptel-default-mode 'org-mode)
  (message "M-x vscode-cp-proxy-set-gptel-backend to start connecting to VSCode")
  )
