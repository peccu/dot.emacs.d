(when (or
       peccu-p
       win-env-p
       ;; wsl-p
       )
  ;; タブの代わりにスペースを使う
  (setq indent-tabs-mode nil)
  (setq-default tab-width 8
                indent-tabs-mode nil)
  )
