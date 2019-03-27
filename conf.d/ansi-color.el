;; http://unix.stackexchange.com/questions/83381/visualizing-ansi-color-escape-codes-in-log-files-correctly-in-emacs
(require 'ansi-color)
(defun ansi-color-buffer()
  (interactive)
  (ansi-color-apply-on-region (point-min) (point-max)))
