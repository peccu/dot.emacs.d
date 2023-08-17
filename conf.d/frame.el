(when (or
       ;; peccu-p
       ;; win-env-p
       wsl-p
       )
  (when (version<= "29" emacs-version)
    ;; https://emacsredux.com/blog/2020/12/04/maximize-the-emacs-frame-on-startup/
    ;; fullwidth, fullheight, fullboth, maximized(cant change size)
    (add-to-list 'initial-frame-alist '(fullscreen . fullheight))
    (add-to-list 'default-frame-alist '(fullscreen . fullheight))
    )
  )
