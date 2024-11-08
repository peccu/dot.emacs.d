(when (or
       peccu-p
       win-env-p
       wsl-p
       )

  (defun snake->kebab (str)
    (replace-regexp-in-string "_" "-" str))
  (defun kebab->pascal (str)
    (let ((los
           (mapcar 'capitalize (split-string str "-" t))))
      (mapconcat 'identity los "")))
  (defun pascal->camel (str)
    (let ((words (split-string (camel->snake str) "_" t)))
      (let ((los
             (append (list (car words))
                     (mapcar 'capitalize (rest words)))))
        (mapconcat 'identity los "")
        )))
  (defun camel->snake (str)
    (ik:decamelize str))

  (defun cycle-case (str)
    (let ((case-fold-search nil))
      (cond
       ((string-match "_" str)          ;snake_case -> kebab-case
        (snake->kebab str))
       ((string-match "-" str)          ;kebab-case -> PascalCase
        (kebab->pascal str))
       ((string-match "^[A-Z]" str)     ;PascalCase -> camelCase
        (pascal->camel str))
       (t                               ;camelCase to snake_case
        (camel->snake str)))))
  ;; (insert (concat " ;; => " (cycle-case "camel_or_snake"))) ;; => camel-or-snake
  ;; (insert (concat " ;; => " (cycle-case "camel-or-snake"))) ;; => CamelOrSnake
  ;; (insert (concat " ;; => " (cycle-case "CamelOrSnake"))) ;; => camelOrSnake
  ;; (insert (concat " ;; => " (cycle-case "camelOrSnake"))) ;; => camel_or_snake
  ;; test CamelOrSnake

  (defun cycle-case-thing-at-point-or-region (s e)
    (interactive "r")
    (unless (use-region-p)
      (let ((bounds (bounds-of-thing-at-point 'symbol)))
        (setq s (car bounds))
        (setq e (cdr bounds))))
    (let* ((buf-str (buffer-substring-no-properties s e))
           (str (cycle-case buf-str)))
      (delete-region s e)
      (insert str)))

  (global-set-key (kbd "M-C") 'cycle-case-thing-at-point-or-region)
  (define-key global-map "\M-C" 'cycle-case-thing-at-point-or-region)

  ;; http://d.hatena.ne.jp/IMAKADO/20091209/1260323922
  ;; http://stackoverflow.com/questions/9288181/converting-from-camelcase-to-in-emacs
  ;; merged

  ;; copied from rails-lib.el
  (defun ik:decamelize (string)
    "Convert from CamelCaseString to camel_case_string."
    (let ((case-fold-search nil))
      (downcase
       (replace-regexp-in-string
        "\\([A-Z]+\\)\\([A-Z][a-z]\\)" "\\1_\\2"
        (replace-regexp-in-string
         "\\([a-z\\d]\\)\\([A-Z]\\)" "\\1_\\2"
         string)))))

  (defun ik:camerize<->decamelize (str)
    (let ((case-fold-search nil))
      (cond
       ((string-match "_" str)
        (let ((los
               (mapcar 'capitalize (split-string str "_" t))))
          (mapconcat 'identity los "")))
       ((string-match "^[A-Z]" str)
        (let ((words (split-string (ik:decamelize str) "_" t)))
          (let ((los
                 (append (list (car words))
                         (mapcar 'capitalize (rest words)))))
            (mapconcat 'identity los "")
            )))
       (t
        (ik:decamelize str)))))
  ;; (ik:camerize<->decamelize "camel_or_snake")
  ;; (ik:camerize<->decamelize "CamelOrSnake")
  ;; (ik:camerize<->decamelize "camelOrSnake")
  ;; (ik:camerize<->decamelize "camel-or-snake")

  (defun ik:camerize<->decamelize-thing-ad-point-or-region (s e)
    (interactive "r")
    (unless (use-region-p)
      (let ((bounds (bounds-of-thing-at-point 'symbol)))
        (setq s (car bounds))
        (setq e (cdr bounds))))
    (let* ((buf-str (buffer-substring-no-properties s e))
           (str (ik:camerize<->decamelize buf-str)))
      (delete-region s e)
      (insert str)))

  ;; (global-set-key (kbd "M-C") 'ik:camerize<->decamelize-thing-ad-point-or-region)
  ;; (define-key global-map "\M-C" 'ik:camerize<->decamelize-thing-ad-point-or-region)


  ;; http://stackoverflow.com/questions/9288181/converting-from-camelcase-to-in-emacs
  (defun un-camelcase-region (begin end)
    (interactive "r")
    (if (use-region-p)
        (progn (replace-regexp "\\([A-Z]\\)" "_\\1" nil (1+ begin) end)
               (downcase-region begin end))
      (un-camelcase-word-at-point)))

  (defun un-camelcase-word-at-point ()
    "un-camelcase the word at point, replacing uppercase chars with
the lowercase version preceded by an underscore.

The first char, if capitalized (eg, PascalCase) is just
downcased, no preceding underscore.
"
    (interactive)
    (save-excursion
      (let ((bounds (bounds-of-thing-at-point 'word)))
        (replace-regexp "\\([A-Z]\\)" "_\\1" nil
                        (1+ (car bounds)) (cdr bounds))
        (downcase-region (car bounds) (cdr bounds)))))
  ;; (local-set-key "\M-\C-C"  'un-camelcase-word-at-point)
  )
