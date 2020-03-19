;; (require 'url-util)
;; (url-hexify-string "やっほー")
;; (url-encode-url "やっほー")

;; http://hins11.jugem.jp/?eid=34
(defun my-url-encode-string (str &optional sys)
  (let ((sys (or sys 'utf-8)))
    (url-hexify-string (encode-coding-string str sys))))

(defun my-url-decode-string (str &optional sys)
  (let ((sys (or sys 'utf-8)))
    (decode-coding-string (url-unhex-string str) sys)))

(defun my-url-decode-region (beg end)
  (interactive "r")
  (let ((pos beg)
        (str (buffer-substring beg end)))
    (goto-char beg)
    (delete-region beg end)
    (insert (my-url-decode-string str 'utf-8))))

(defun my-url-encode-region (beg end)
  (interactive "r")
  (let ((pos beg)
        (str (buffer-substring beg end)))
    (goto-char beg)
    (delete-region beg end)
    (insert (my-url-encode-string str 'utf-8))))
