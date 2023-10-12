(dolist (dir (list
              "/sbin"
              "/usr/sbin"
              "/bin"
              "/usr/bin"
              ;; "/opt/local/bin"
              ;; "/sw/bin"
              "/usr/local/bin"
              (expand-file-name (concat user-emacs-directory "bin"))
              (expand-file-name "~/bin")
              (expand-file-name "~/Library/Haskell/bin")
              (expand-file-name "~/../../AppData/Local/Programs/msys64/usr/bin")
              ;; "/Apps/gnupack_devel-11.00/app/cygwin/cygwin/usr/local/bin"
              ;; "/Apps/gnupack_devel-11.00/app/cygwin/cygwin/usr/bin"
              ;; "/Apps/gnupack_devel-11.00/app/cygwin/cygwin/bin/"
              ;; "/Apps/gnupack_devel-11.00/app/cygwin/cygwin/usr/sbin/"
              ;; "/Apps/gnupack_devel-11.00/app/cygwin/cygwin/sbin/"
              ))
 ;; PATH と exec-path に同じ物を追加します
 (when (and (file-exists-p dir) (not (member dir exec-path)))
   (setenv "PATH" (concat dir ":" (getenv "PATH")))
   (setq exec-path (append (list dir) exec-path))))

(require-with-install 'exec-path-from-shell)
(when (and (memq window-system '(mac ns))
           (functionp 'exec-path-from-shell-initialize))
  (exec-path-from-shell-initialize)
  (add-hook' after-init-hook 'exec-path-from-shell-initialize))

(defun strip-duplicates (list)
  (let ((new-list nil))
    (while list
      (when (and (car list) (not (member (car list) new-list)))
        (setq new-list (cons (car list) new-list)))
      (setq list (cdr list)))
    (nreverse new-list)))
;; (setq old-exec-path exec-path)
;; exec-path

;; (strip-duplicates exec-path)


;; (let ((exec-path-from-shell-debug t))
;;   (exec-path-from-shell-getenvs '("PATH")))
