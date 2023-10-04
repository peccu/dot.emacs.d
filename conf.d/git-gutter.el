(when (or
       peccu-p
       win-env-p
       ;; wsl-p
       )
  (when (version<= "29" emacs-version)
    ;; melpa version does not support emacs 29
    ;; https://github.com/emacsorphanage/git-gutter/commit/c6547febbf9bed870df23254757296b6dd9a349a
    (add-submodule-to-load-path "git/git-gutter")
    )
  ;; (require 'git-gutter)

  ;; ;; If you enable global minor mode
  ;; (global-git-gutter-mode t)

  ;; ;; If you would like to use git-gutter.el and linum-mode
  ;; (git-gutter:linum-setup)

  ;; If you enable git-gutter-mode for some modes
  ;; (add-hook 'ruby-mode-hook 'git-gutter-mode)

  (global-set-key (kbd "C-x C-g") 'git-gutter)
  (global-set-key (kbd "C-x v =") 'git-gutter:popup-hunk)

  ;; Jump to next/previous hunk
  (global-set-key (kbd "C-x v p") 'git-gutter:previous-hunk)
  (global-set-key (kbd "C-x v n") 'git-gutter:next-hunk)

  ;; Stage current hunk
  (global-set-key (kbd "C-x v s") 'git-gutter:stage-hunk)

  ;; Revert current hunk
  (global-set-key (kbd "C-x v r") 'git-gutter:revert-hunk)

  ;; ;; Mark current hunk
  ;; (global-set-key (kbd "C-x v SPC") #'git-gutter:mark-hunk)

  (require-with-install 'git-gutter-fringe)

  ;; (set-face-foreground 'git-gutter-fr:modified "yellow")
  ;; (set-face-foreground 'git-gutter-fr:added    "blue")
  ;; (set-face-foreground 'git-gutter-fr:deleted  "white")

  ;; (setq git-gutter-fr:side 'right-fringe)
  ;; Please adjust fringe width if your own sign is too big.
  (setq-default left-fringe-width  20)
  ;; (setq-default right-fringe-width 20)

  (fringe-helper-define 'git-gutter-fr:added nil
                        ".XXXXXX."
                        "XX....XX"
                        "XX....XX"
                        "XX....XX"
                        "XXXXXXXX"
                        "XXXXXXXX"
                        "XX....XX"
                        "XX....XX")

  (fringe-helper-define 'git-gutter-fr:deleted nil
                        "XXXXXX.."
                        "XX....X."
                        "XX.....X"
                        "XX.....X"
                        "XX.....X"
                        "XX.....X"
                        "XX....X."
                        "XXXXXX..")

  (fringe-helper-define 'git-gutter-fr:modified nil
                        "XXX.XXXX"
                        "X..X...X"
                        "X..X...X"
                        "X..X...X"
                        "X..X...X"
                        "X..X...X"
                        "X..X...X"
                        "X..X...X")

  (fringe-helper-define 'git-gutter-fr:added nil
                        "...XX..."
                        "...XX..."
                        "...XX..."
                        "XXXXXXXX"
                        "XXXXXXXX"
                        "...XX..."
                        "...XX..."
                        "...XX...")

  (fringe-helper-define 'git-gutter-fr:deleted nil
                        "........"
                        "........"
                        "........"
                        "XXXXXXXX"
                        "XXXXXXXX"
                        "........"
                        "........"
                        "........")

  (fringe-helper-define 'git-gutter-fr:modified nil
                        "..XXXX.."
                        ".X....X."
                        "X......X"
                        "X......X"
                        "X......X"
                        "X......X"
                        ".X....X."
                        "..XXXX..")
  )
