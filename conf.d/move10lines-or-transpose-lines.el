;; http://blog.livedoor.jp/bw256/archives/689376.html
(require 'transpose-line-or-region)

(defun move-up-10line ()
  "10行移動する"
  (interactive)
  (forward-line -10))

(defun move-down-10line ()
  "10行移動する"
  (interactive)
  (forward-line 10))

(defun move10lines-or-transpose-lines-up (&optional n)
  (interactive "*p")
  (if (and transient-mark-mode mark-active)
      (transpose-line-or-region (- (if n n 1)))
    (move-up-10line)))

(defun move10lines-or-transpose-lines-down (&optional n)
  (interactive "*p")
  (if (and transient-mark-mode mark-active)
      (transpose-line-or-region (if n n 1))
    (move-down-10line)))

(global-set-key (kbd "<M-up>") 'move10lines-or-transpose-lines-up)
(global-set-key (kbd "<M-down>") 'move10lines-or-transpose-lines-down)
