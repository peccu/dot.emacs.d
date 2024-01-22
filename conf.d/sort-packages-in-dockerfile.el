(when (or
       peccu-p
       win-env-p
       wsl-p
       )
  (defun sort-packages-in-dockerfile ()
    "sort lines except first and last line"
    (save-excursion
      (let ((beg) (end))
        (next-line 2)                   ;ignore apt-get/pip
        (beginning-of-line)
        (setq beg (point))
        (forward-paragraph)
        (next-line -1)                  ;ignore echo installed
        (setq end (point))
        (sort-lines nil beg end))))
  )
