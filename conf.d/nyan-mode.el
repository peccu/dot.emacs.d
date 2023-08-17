(when (or
       peccu-p
       win-env-p
       ;; wsl-p
       )
  (require-with-install 'nyan-mode)
  (setq nyan-animation-frame-interval 0.1)
  (setq nyan-bar-length 6)
  (nyan-mode)
  (nyan-start-animation)
  ;; (nyan-stop-animation)
  )
