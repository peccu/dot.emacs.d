(when (or
       peccu-p
       win-env-p
       wsl-p
       )
  ;; ;; move splited frame
  ;; ;; Shift-(left|right|up|down)
  (windmove-default-keybindings)
  (setq windmove-wrap-around t)
  (defun counter-other-window ()
    (interactive)
    (other-window -1))
  (global-set-key (kbd "C-;") 'other-window)
  ;; (global-set-key (kbd "C-:") 'counter-other-window)
  (global-set-key (kbd "C-M-;") 'counter-other-window)
  )
