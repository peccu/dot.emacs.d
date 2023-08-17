(when (or
       peccu-p
       win-env-p
       ;; wsl-p
       )
  ;; cf.http://d.hatena.ne.jp/rubikitch/20080413/1208029571
  (defun start-or-end-macro (arg)
    (interactive "P")
    (if defining-kbd-macro
        (if arg
            (end-kbd-macro arg)
          (end-kbd-macro))
      (start-kbd-macro arg)))
  (global-set-key (kbd "<f6>") 'call-last-kbd-macro)
  (global-set-key (kbd "S-<f6>") 'start-or-end-macro)
  )
