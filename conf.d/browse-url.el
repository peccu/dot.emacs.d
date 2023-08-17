(when (or
       ;; peccu-p
       win-env-p
       wsl-p
       )
  (when (and (eq system-type 'gnu/linux)
             (eq window-system 'pgtk)
             (getenv "WSLENV"))
    ;; https://emacsredux.com/blog/2021/12/19/wsl-specific-emacs-configuration/
    ;; Teach Emacs how to open links in your default Windows browser
    (let ((cmd-exe "/mnt/c/Windows/System32/cmd.exe")
          (cmd-args '("/c" "start")))
      (when (file-exists-p cmd-exe)
        (setq browse-url-generic-program  cmd-exe
              browse-url-generic-args     cmd-args
              browse-url-browser-function 'browse-url-generic
              search-web-default-browser 'browse-url-generic))))
  )
