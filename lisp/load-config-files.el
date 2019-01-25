(defun load-config-files (d)
  (unless d
    (error "load-config-files:directory is not specified"))
  (let* ((dir (concat user-emacs-directory d))
         (el-suffix "\\.el\\'")
         (files (mapcar
                 (lambda (path) (replace-regexp-in-string el-suffix "" path))
                 (directory-files dir t el-suffix))))
    (while files
      (message (car files))
      (load (car files))
      (setq files (cdr files)))))
(provide 'load-config-files)
