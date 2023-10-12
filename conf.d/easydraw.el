(when (or
       peccu-p
       win-env-p
       wsl-p
       )
  (add-submodule-to-load-path "git/el-easydraw")
  (require 'edraw-color-picker)

  ;; https://github.com/misohena/el-easydraw#color-picker

  ;; (autoload 'edraw-color-picker-replace-color-at "edraw-color-picker" nil t)
  ;; (autoload 'edraw-color-picker-replace-or-insert-color-at-point "edraw-color-picker" nil t)

  (defun my-edraw-color-picker-add-keys (map)
    ;; Replaces the color of the clicked location
    (define-key map [mouse-1] #'edraw-color-picker-replace-color-at)
    ;; C-c C-o replaces the color in place or adds color
    (define-key map (kbd "C-c C-o")
      #'edraw-color-picker-replace-or-insert-color-at-point))

  (defun my-edraw-color-picker-enable ()
    (my-edraw-color-picker-add-keys (or (current-local-map)
                                        (let ((map (make-sparse-keymap)))
                                          (use-local-map map)
                                          map))))

  (add-hook 'css-mode-hook 'my-edraw-color-picker-enable)
  (add-hook 'web-mode-hook 'my-edraw-color-picker-enable)
  ;; (add-hook 'mhtml-mode-hook 'my-edraw-color-picker-enable)

  )
