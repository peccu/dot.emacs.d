(when (or
       peccu-p
       win-env-p
       ;; wsl-p
       )
  (add-hook 'dired-mode-hook
            (lambda ()
              (define-key (current-local-map) (kbd "<M-up>") 'dired-up-directory)
              (define-key (current-local-map) (kbd "<M-down>") 'dired-find-file)))
  ;; http://news.mynavi.jp/column/osxhack/043/index.html
  (setq dired-load-hook '(lambda () (load "dired-x")))
  (setq dired-guess-shell-alist-user
        '(("\\.\\(ppt\\|PPT\\|pptx\\|PPTX\\)\\'" "open -a Keynote")
          ("\\.\\(xls\\|XLS\\|xlsx\\|XLSX\\)\\'" "qlmanage -p")
          ("\\.\\(jpg\\|JPG\\|png\\|PNG\\|pdf\\|PDF\\)\\'" "qlmanage -p")
          ("\\.\\(m4a\\|mp3\\|wav\\)\\'" "afplay -q 1 * &")))

  ;; http://stackoverflow.com/questions/1431351/how-do-i-uncompress-unzip-within-emacs
  ;; zipを解凍する
  ;; Z key
  (eval-after-load "dired-aux"
    '(add-to-list 'dired-compress-file-suffixes
                  '("\\.zip\\'" ".zip" "unzip")))

  ;; 圧縮する
  ;; z key
  (add-hook 'dired-mode-hook
            (lambda ()
              (define-key dired-mode-map "z" 'dired-encrypt-zip-files)))
  ;; http://stackoverflow.com/a/1432116
  (defun dired-zip-files (zip-file)
    "Create an archive containing the marked files."
    (interactive "sEnter name of zip file: ")

    ;; create the zip file
    (let ((zip-file (if (string-match ".zip$" zip-file) zip-file (concat zip-file ".zip"))))
      (shell-command
       (concat "zip "
               zip-file
               " "
               (concat-string-list
                (mapcar
                 '(lambda (filename)
                    (file-name-nondirectory filename))
                 (dired-get-marked-files))))))

    (revert-buffer)

    ;; remove the mark on all the files  "*" to " "
    ;; (dired-change-marks 42 ?\040)
    ;; mark zip file
    ;; (dired-mark-files-regexp (filename-to-regexp zip-file))
    )

  (defun concat-string-list (list)
    "Return a string which is a concatenation of all elements of the list separated by spaces"
    (mapconcat '(lambda (obj) (format "%s" obj)) list " "))

  ;; with-password-version
  (defun dired-encrypt-zip-files (arg)
    "Create an encrypted archive containing the marked files."
    (interactive "P")
    ;; create the zip file
    (let ((password (if (string= ""
                                 (if (equal arg '(4))
                                     (setq pass (read-passwd "enter password: "))
                                   ""))
                        ""                ;neither C-u prefix nor not entered
                      (concat "--password '" pass "' "))) ;pass inputed
          (zip-file (read-file-name "Enter zip file name: ")))
      (setq zip-file (if (string-match ".zip$" zip-file)
                         zip-file
                       (concat zip-file ".zip")))
      (shell-command
       (concat "zip "
               password
               zip-file
               " "
               (concat-string-list
                (mapcar
                 '(lambda (filename)
                    (file-name-nondirectory filename))
                 (dired-get-marked-files))))))

    (revert-buffer)

    ;; remove the mark on all the files  "*" to " "
    ;; (dired-change-marks 42 ?\040)
    ;; mark zip file
    ;; (dired-mark-files-regexp (filename-to-regexp zip-file))
    )
  )
