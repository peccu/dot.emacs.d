;;; transpose-line-or-region.el --- line or region is transposed

;; -*- Emacs-Lisp -*-
;; Last updated: <2010/09/01 15:37:11>

;; org(Common lisp): http://blue.ribbon.to/~aotororo/prog/200310.html#d08_t4

;;; Installation:

;; You need to add to .emacs:

;;   (transient-mark-mode t)
;;   (pc-selection-mode)

;;   (require 'transpose_line_or_region)
;;   (global-set-key [M-up] 'transpose-line-or-region-up)
;;   (global-set-key [M-down] 'transpose-line-or-region-down)

;;; History:

;; 0.02 2010/09/01 : scroll suport.
;; 0.01 2010/08/28 : Initial revision

;;; Code: 

(defun transpose-line-or-region (n)
  "line or region is transposed."
  (interactive "*p")
  (let* ((pre-selection-type (and transient-mark-mode mark-active))
         (deactivate-mark nil)
         (column (current-column))
         beg end)
    (if pre-selection-type
        ;; case region
        (progn
          (setq beg (region-beginning))
          (setq end (region-end)))
      (progn
        ;; case line
        (setq beg (progn (beginning-of-line) (point)))
        (setq end (progn
                    (forward-line 1)
                    (if (and (eobp) (< 0 (current-column)))
                        (progn (end-of-line) (insert "\n")))
                    (point)))))
    (when (and (goto-char end) (bolp) (goto-char beg) (bolp))
      (insert (prog1
                  (buffer-substring beg end)
                (delete-region beg end)
                (forward-line n)
                (if pre-selection-type (setq beg (point)))
                (and (minusp (1- (transpose-get-current-line))) (recenter 1))))
      (if pre-selection-type
          ;; case region
          (push-mark beg t t)
        ;; case line
        (progn
          (forward-line -1)
          (move-to-column column))))))

(defun transpose-get-current-line ()
  (+ (count-lines (window-start) (point))
     (if (= (current-column) 0) 1 0) -1))

(defun transpose-line-or-region-up (&optional n)
  (interactive "*p")
  (transpose-line-or-region (- (if n n 1))))

(defun transpose-line-or-region-down (&optional n)
  (interactive "*p")
  (transpose-line-or-region (if n n 1)))

(provide 'transpose-line-or-region)

;; end of file
