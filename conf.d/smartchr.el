(when (or
       peccu-p
       win-env-p
       wsl-p
       )
  (add-submodule-to-load-path "git/emacs-smartchr/")
  (require 'smartchr)
  ;; (global-set-key (kbd "=") (smartchr '(" = " "=" " => " " == " " != ")))

  ;; (define-key org-mode-map (kbd "$") (smartchr '(" $`!!'$ " "#+begin_latex
  ;;   % \\setcounter{equation}{35}
  ;;   \\begin{equation}
  ;;   `!!'
  ;;   \\label{}
  ;;   \\end{equation}
  ;; #+end_latex
  ;; " "$")))
  ;; (global-set-key (kbd "{") (smartchr '("{" "{`!!'}")))
  (global-set-key (kbd "\"") (smartchr '("\"" "\"`!!'\"")))
  (global-set-key (kbd "'") (smartchr '("'" "'`!!''")))
  ;; (global-set-key (kbd "(") (smartchr '("(" "(`!!')")))

  (defun my-smartchr-keybindings-js ()
    ;; (local-set-key (kbd "{") (smartchr '("{" my-smartchr-braces "{`!!'}")))
    (local-set-key (kbd "(") (smartchr '("(" "(`!!')" "() => {}")))
    )
  (dolist (hook (list
                 'js2-mode-hook
                 'web-mode-hook
                 'typescript-mode-hook
                 ))
    (add-hook hook 'my-smartchr-keybindings-js))

;;; http://tech.kayac.com/archive/emacs-tips-smartchr.html
  ;; (global-set-key (kbd ">") (smartchr '(">" " => " " => '`!!''" " => \"`!!'\"")))

  ;; ;;
  ;; (global-set-key (kbd "F") (smartchr '("F" "$" "$_" "$_->" "@$")))

  ;; ;;
  ;; (define-key cperl-mode-map (kbd "M") (smartchr '("M" "my $`!!' = " "my ($self, $`!!') = @_;" "my @`!!' = ")))

  ;; ;;
  ;; (defun perl-smartchr:sub ()
  ;;   ""
  ;;   "sub `!!' {
  ;;     my ($self) = @_;

  ;; }")
  ;; (define-key cperl-mode-map (kbd "S") (smartchr '("S" perl-smartchr:sub "sub { `!!' }")))

  ;; ;;
  ;; (defun ik:insert-eol (s)
  ;;   (interactive)
  ;;   (lexical-let ((s s))
  ;;     (smartchr-make-struct
  ;;      :insert-fn (lambda ()
  ;;                   (save-excursion
  ;;                     (goto-char (point-at-eol))
  ;;                     (when (not (string= (char-to-string (preceding-char)) s))
  ;;                       (insert s))))
  ;;      :cleanup-fn (lambda ()
  ;;                    (save-excursion
  ;;                      (goto-char (point-at-eol))
  ;;                      (delete-backward-char (length s)))))))

  ;; (defun ik:insert-semicolon-eol ()
  ;;   (ik:insert-eol ";"))

  ;; (global-set-key (kbd "j")
  ;;                   (smartchr '("j" ik:insert-semicolon-eol)))

;;; http://d.hatena.ne.jp/kitokitoki/20091129/p2
  ;; (global-set-key (kbd "R") (smartchr '("R" "rubikitchさん" " id:rubikitch")))

  ;; うまくいかなかった
  ;; (defun term-toggle-sub-mode ()
  ;;   "Switch term-line-mode <-> term-char-mode."
  ;;   (interactive)
  ;;   (if (term-in-char-mode)
  ;;       (term-line-mode)
  ;;     (term-char-mode)))
  ;; (define-key term-mode-map (kbd "C-c C-j") 'term-toggle-sub-mode)
  ;; (define-key term-mode-map (kbd "C-c C-k") 'term-toggle-sub-mode)

  ;; http://d.hatena.ne.jp/pogin/20111230/1325229996
  (defun my-smartchr-braces ()
    "Insert a pair of braces like below.
  \n    {\n    `!!'\n}"
    ;; foo {
    ;;     `!!'
    ;; }
    (lexical-let (beg end)
      (smartchr-make-struct
       :insert-fn (lambda ()
                    (setq beg (point))
                    (insert "{\n\n}")
                    (indent-region beg (point))
                    (forward-line -1)
                    (indent-according-to-mode)
                    (goto-char (point-at-eol))
                    (setq end (save-excursion
                                (re-search-forward "[[:space:][:cntrl:]]+}" nil t))))
       :cleanup-fn (lambda ()
                     (delete-region beg end))
       )))

  ;; (defun my-smartchr-comment ()
  ;;   "Insert a multiline comment like below.
  ;; \n/*\n * `!!'\n */"
  ;;   ;; /*
  ;;   ;;  * `!!'
  ;;   ;;  */
  ;;   (lexical-let (beg end)
  ;;     (smartchr-make-struct
  ;;      :insert-fn (lambda ()
  ;;                   (setq beg (point))
  ;;                   (insert "/*\n* \n*/")
  ;;                   (indent-region beg (point))
  ;;                   (setq end (point))
  ;;                   (forward-line -1)
  ;;                   (goto-char (point-at-eol)))
  ;;      :cleanup-fn (lambda ()
  ;;                    (delete-region beg end))
  ;;      )))

  ;; (defun my-smartchr-semicolon ()
  ;;   "Insert a semicolon at end of line."
  ;;   (smartchr-make-struct
  ;;    :insert-fn (lambda ()
  ;;                 (save-excursion
  ;;                   (goto-char (point-at-eol))
  ;;                   (insert ";")))
  ;;    :cleanup-fn (lambda ()
  ;;                  (save-excursion
  ;;                    (goto-char (point-at-eol))
  ;;                    (delete-backward-char 1)))
  ;;    ))

  (defun my-smartchr-keybindings ()
    ;; !! がカーソルの位置
    (local-set-key (kbd "=") (smartchr '("=" " = " " => " " == " " != ")))
    ;; (local-set-key (kbd "+") (smartchr '("+" " + " "++" " += ")))
    ;; (local-set-key (kbd "-") (smartchr '("-" " - " "--" " -= ")))
    ;; (local-set-key (kbd "(") (smartchr '("(`!!')" "(")))
    ;; (local-set-key (kbd "[") (smartchr '("[`!!']" "[[`!!']]" "[")))
    ;; (local-set-key (kbd "{") (smartchr '("{" "{`!!'}" my-smartchr-braces)))
    ;; ;;バッククォート
    ;; (local-set-key (kbd "`") (smartchr '("\``!!''" "\`")))
    ;; ;;ダブルクォーテーション
    ;; (local-set-key (kbd "\"") (smartchr '("\"`!!'\"" "\"")))
    ;; ;;シングルクォート
    ;; (local-set-key (kbd "\'") (smartchr '("\'`!!'\'" "\'")))
    ;; (local-set-key (kbd ">") (smartchr '(">" " > " " => " " >> ")))
    ;; (local-set-key (kbd "<") (smartchr '("<" " < " " << " "<`!!'>")))
    ;; (local-set-key (kbd ",") (smartchr '(", " ",")))
    ;; (local-set-key (kbd ".") (smartchr '("." " . ")))
    ;; (local-set-key (kbd "?") (smartchr '("?" "? `!!' " "<?`!!'?>")))
    ;; (local-set-key (kbd "!") (smartchr '("!" " != ")))
    ;; (local-set-key (kbd "&") (smartchr '("&" " && ")))
    ;; (local-set-key (kbd "|") (smartchr '("|" " || ")))
    ;; (local-set-key (kbd "/") (smartchr '("/" "/* `!!' */" my-smartchr-comment)))
    ;; (local-set-key (kbd ";") (smartchr '(";" my-smartchr-semicolon)))
    )

  ;; (defun my-smartchr-keybindings-lisp ()
  ;;   (local-set-key (kbd "(") (smartchr '("(`!!')" "(")))
  ;;   (local-set-key (kbd "[") (smartchr '("[`!!']" "[[`!!']]" "[")))
  ;;   (local-set-key (kbd "`") (smartchr '("\``!!''" "\`")))
  ;;   (local-set-key (kbd "\"") (smartchr '("\"`!!'\"" "\"")))
  ;;   (local-set-key (kbd ".") (smartchr '("." " . ")))
  ;;   )

  ;; (defun my-smartchr-keybindings-objc ()
  ;;   (local-set-key (kbd "@") (smartchr '("@\"`!!'\"" "@")))
  ;;   (local-set-key (kbd "[") (smartchr '("[`!!']" "[[`!!']]" "[[[`!!']]]" "["))))

  (dolist (hook (list
                 'c-mode-common-hook
                 'c++-mode-hook
                 'php-mode-hook
                 'ruby-mode-hook
                 'cperl-mode-hook
                 'javascript-mode-hook
                 'js-mode-hook
                 'js2-mode-hook
                 'text-mode-hook
                 ))
    (add-hook hook 'my-smartchr-keybindings))

  ;; (dolist (hook (list
  ;;                'lisp-mode-hook
  ;;                'emacs-lisp-mode-hook
  ;;                'lisp-interaction-mode-hook
  ;;                'inferior-gauche-mode-hook
  ;;                'scheme-mode-hook
  ;;                ))
  ;;   (add-hook hook 'my-smartchr-keybindings-lisp))


  ;; (add-hook 'objc-mode-hook 'my-smartchr-keybindings-objc)

  ;; (defun my-smartchr-keybindings-html ()
  ;;   ;; !! がカーソルの位置
  ;;   (local-set-key (kbd "=") (smartchr '("=" " = " " == ")))
  ;;   (local-set-key (kbd "(") (smartchr '("(`!!')" "(")))
  ;;   (local-set-key (kbd "[") (smartchr '("[`!!']" "[[`!!']]" "[")))
  ;;   (local-set-key (kbd "{") (smartchr '("{" "{`!!'}" my-smartchr-braces)))
  ;;   ;;ダブルクォート
  ;;   (local-set-key (kbd "\"") (smartchr '("\"`!!'\"" "\"")))
  ;;   ;;シングルクォート
  ;;   (local-set-key (kbd "\'") (smartchr '("\'`!!'\'" "\'")))
  ;;   (local-set-key (kbd "<") (smartchr '("<`!!'>" "</`!!'>" "<")))
  ;;   (local-set-key (kbd ",") (smartchr '(", " ",")))
  ;;   (local-set-key (kbd ".") (smartchr '("." " . ")))
  ;;   (local-set-key (kbd "?") (smartchr '("?" "? `!!' " "<?`!!'?>")))
  ;;   (local-set-key (kbd "!") (smartchr '("!" "<!-- `!!' -->")))
  ;;   (local-set-key (kbd ";") (smartchr '(";" my-smartchr-semicolon)))
  ;;   (local-set-key (kbd ":") (smartchr '(": " ":")))
  ;;   (local-set-key (kbd "/") (smartchr '("/" "/* `!!' */" my-smartchr-comment)))
  ;;   )
  ;; (dolist (hook (list
  ;;                'html-mode-hook
  ;;                'css-mode-hook
  ;;                ))
  ;;   (add-hook hook 'my-smartchr-keybindings-html))
  )
