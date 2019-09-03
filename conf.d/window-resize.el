;; Ctrl-矢印に割り当てるアイデア
;; http://d.hatena.ne.jp/khiker/20100118/emacs_arrow
;; 各方向の関数名
;; http://d.hatena.ne.jp/khiker/20100119/window_resize
(global-set-key (kbd "C-<up>") '(lambda (arg) (interactive "p") (shrink-window arg)))
(global-set-key (kbd "C-<down>") '(lambda (arg) (interactive "p") (enlarge-window arg)))
(global-set-key (kbd "C-<right>") '(lambda (arg) (interactive "p") (enlarge-window-horizontally arg)))
(global-set-key (kbd "C-<left>") '(lambda (arg) (interactive "p") (shrink-window-horizontally arg)))
