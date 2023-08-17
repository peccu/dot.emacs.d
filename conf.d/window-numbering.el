(when (or
       peccu-p
       win-env-p
       wsl-p
       )
  (require-with-install 'window-numbering)
  ;; (setq window-numbering-assign-func
  ;;       (lambda () (when (equal (buffer-name) "*Calculator*") 9)))
  (window-numbering-mode t)
  )
