(when (or
       peccu-p
       win-env-p
       wsl-p
       )
  ;; cf.http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=swap%20screen
  ;;汎用機の SPF (mule みたいなやつ) には
  ;;画面を 2 分割したときの 上下を入れ替える swap screen
  ;;というのが PF 何番かにわりあてられていました。
  (defun swap-screen()
    "Swap two screen,leaving cursor at current window."
    (interactive)
    (let ((thiswin (selected-window))
          (nextbuf (window-buffer (next-window))))
      (set-window-buffer (next-window) (window-buffer))
      (set-window-buffer thiswin nextbuf)))
  (defun swap-screen-with-cursor()
    "Swap two screen,with cursor in same buffer."
    (interactive)
    (let ((thiswin (selected-window))
          (thisbuf (window-buffer)))
      (other-window 1)
      (set-window-buffer thiswin (window-buffer))
      (set-window-buffer (selected-window) thisbuf)))
  (global-set-key (kbd "<f2>") 'swap-screen)
  (global-set-key (kbd "<S-f2>") 'swap-screen-with-cursor)
  )
