(when (or
       peccu-p
       win-env-p
       wsl-p
       )
  ;; http://www.emacswiki.org/emacs/WinnerMode
  (when (fboundp 'winner-mode)
    (winner-mode 1))
  )
