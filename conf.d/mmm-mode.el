(when (or
       peccu-p
       win-env-p
       wsl-p
       )
  ;; mainly used in vue-mode
  ;; https://github.com/AdamNiederer/vue-mode#how-do-i-disable-that-ugly-background-color
  (add-hook 'mmm-mode-hook
            (lambda ()
              (set-face-background 'mmm-default-submode-face nil)))
  )
