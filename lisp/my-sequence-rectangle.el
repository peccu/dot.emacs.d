;;;; my-sequence-rectangle.el --- Insert Sequence Rectangle

;; Author: Kentaro Shimatani <kentarou.shimatani@gmail.com>
;; Created: 1 Sep 2010
;; Keywords: rectangle, sequence

;;; Code:


(defvar my-rectangle-seq-format "%d")
(defun my-sequence-rectangle (start end first incr format)
  "Resequence each line of rectangle starting from FIRST.
The numbers are formatted according to the FORMAT string.

Called from a program, takes five args; START, END, FIRST, INCR and FORMAT."
  (interactive
   (progn (barf-if-buffer-read-only)
          (list
           (region-beginning)
           (region-end)
           (if current-prefix-arg
               (prefix-numeric-value current-prefix-arg)
             (string-to-number
              (read-string "Start value: (0) " nil nil "0")))
           (string-to-number
            (read-string "Increment: (1) " nil nil "1"))
           (read-string (concat "Format: (" my-rectangle-seq-format ") ")))))
  (if (= (length format) 0)
      (setq format my-rectangle-seq-format)
    (setq my-rectangle-seq-format format))
  (delete-rectangle start end)
  (apply-on-rectangle 'my-string-rectangle-line start end
                      '(lambda ()
                         (insert (format format first))
                         (setq first (+ first incr)))))

(defun my-string-rectangle-line (startcol endcol func)
  (move-to-column startcol t)
  (funcall func))
(provide 'my-sequence-rectangle)
