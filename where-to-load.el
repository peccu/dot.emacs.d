;; machine-type predicates
;; load-file path
(setq where-to-load
      (cond
       ;; peccu で実行中の場合
       (peccu-p
        "boot-a")
       (win-env-p
        "boot-win")
       (wsl-p
        "boot-wsl")
       ;; 指定されていないマシンで実行中の場合
       (t
        (progn
          (message (concat "Unknown Host: " system-name))
          nil))))
;; (message where-to-load)

(defun user-data-directory (file)
  "Return user data file path like '~/.emacs.d/data/env-name/.emacs.bmk'."
  (concat user-emacs-directory "data/" where-to-load "/" file))
