;; http://i-yt.info/?date=20090321#p01
;; https://www.emacswiki.org/emacs/AnythingSources#h5o-54

(defun win-switch-to-window1()
  (interactive) (let ((last-command-char ?1)) (call-interactively 'win-switch-to-window)))
(defun win-switch-to-window2()
  (interactive) (let ((last-command-char ?2)) (call-interactively 'win-switch-to-window)))
(defun win-switch-to-window3()
  (interactive) (let ((last-command-char ?3)) (call-interactively 'win-switch-to-window)))
(defun win-switch-to-window4()
  (interactive) (let ((last-command-char ?4)) (call-interactively 'win-switch-to-window)))
(defun win-switch-to-window5()
  (interactive) (let ((last-command-char ?5)) (call-interactively 'win-switch-to-window)))
(defun win-switch-to-window6()
  (interactive) (let ((last-command-char ?6)) (call-interactively 'win-switch-to-window)))
(defun win-switch-to-window7()
  (interactive) (let ((last-command-char ?7)) (call-interactively 'win-switch-to-window)))
(defun win-switch-to-window8()
  (interactive) (let ((last-command-char ?8)) (call-interactively 'win-switch-to-window)))
(defun win-switch-to-window9()
  (interactive) (let ((last-command-char ?9)) (call-interactively 'win-switch-to-window)))
(defun win-switch-to-last-window()
  (interactive) (win:switch-window win:last-config))

(setq anything-c-source-other-windows
      '((name . "Other Windows")
        (candidates . (lambda ()
                        (win:store-config win:current-config)
                        (let ((i 1) (l (list))
                              (form (format "[%%c]%%s %%-%ds [%%s]" win:names-maxl)))
                          (while (< i win:max-configs)
                            (add-to-list 'l
                                         (if (aref win:configs i)
                                             (format form
                                                     (+ win:base-key i)
                                                     (cond ((= i win:current-config) "*")
                                                           ((= i win:last-config) "+")
                                                           (t " "))
                                                     (format "%s" (aref win:names-prefix i))
                                                     (aref win:names i))
                                           (format form (+ win:base-key i) " " "" "")))
                            (setq i (1+ i)))
                          (sort l 'string<))))
        (action . (("Switch to Other Window" . (lambda (arg)
                                                 (if (string-match "^\\[w\\(.\\)\\]" arg)
                                                     (let ((num (string-to-number (match-string 1 arg))))
                                                       (call-interactively (intern (format "win-switch-to-window%d" num)))
                                                       ))))))
        ))

(provide 'anything-c-source-other-windows)
