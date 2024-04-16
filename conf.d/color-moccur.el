(when (or
       peccu-p
       win-env-p
       ;; wsl-p
       )
  ;; curl -Lo ~/AppData/Roaming/.emacs.d/lisp/color-moccur.el https://github.com/emacsmirror/color-moccur/raw/master/color-moccur.el
  (require-with-install 'color-moccur)
  ;; this includes dmoccur
  ;; (global-set-key (kbd "C-M-o") 'dmoccur)
  (global-set-key (kbd "C-M-o") 'moccur-grep-find)

  ;; (global-set-key (kbd "C-x C-o") 'occur-by-moccur)
  ;; (define-key Buffer-menu-mode-map "O" 'Buffer-menu-moccur)
  ;; (define-key dired-mode-map "O" 'dired-do-moccur)
  ;; (global-set-key (kbd "C-c C-x C-o") 'moccur)
  ;; (global-set-key (kbd "M-f") 'grep-buffers)
  ;; (global-set-key (kbd "C-c C-o") 'search-buffers)

  ;; M-x moccur : find regexp in all buffers
  ;; M-x moccur-grep : find regexp in current directory
  ;; M-x moccur-grep-find : find regexp in current directory recursively
  ;; M-x isearch-moccur (C-s -> M-o) : moccur with current isearch
  ;; M-x isearch-moccur (C-s -> M-O) : moccur with current isearch all buffers
  ;; M-x occur-by-moccur : search current buffer by moccur
  ;; M-x dired-do-moccur : moccur for marked files (in dired)
  ;; M-x search-buffers : search regexp in all buffers
  ;; M-x grep-buffers : grep all visited files
  ;; M-x dmoccur : open files and search by moccur
  ;;   dmoccur-mask : pattern for open files (default is ".*")
  ;;   dmoccur-exclusion-mask : exclude files pattern
  ;;   dmoccur-maximum-size : file opening limit by size
  ;; C-u M-x dmoccur : save list of directory for dmoccur
  ;;   dmoccur-list : saved list

  (custom-set-variables
   ;; disable preview in cursor move
   '(moccur-following-mode-toggle nil)
   '(moccur-grep-following-mode-toggle nil)
   ;; pickup word at point
   '(moccur-grep-default-word-near-point t)
   ;; recursive search
   '(dmoccur-recursive-search t)
   )

  ;; dired moccur marked files
  (add-hook 'dired-mode-hook ;dired
            '(lambda ()
               (local-set-key (kbd "O") 'dired-do-moccur)))

  (setq dmoccur-list
        '(
          ;; defaults
          ("dir" default-directory (".*") dir)
          ;; ("lisp" "~/mylisp/" ("\\.el" "\\.*texi") nil)

          ;;name    directory         mask               option
          ("config" "~/.emacs.d/"     ("\\.js" "\\.el$")  nil)

          ;; ;; sub means you can select sub directory
          ;; ("emacs"  "d:/unix/emacs/"  (".*")              sub)
          ;; multi-directory can be setted if option is nil

          ;; ;; In ~/mylisp, dmoccur search files recursively.
          ;; ;; and dmoccur search files in ~/user.
          ;; ("test-recursive"
          ;;  (("~/mylisp" t)
          ;;   ("~/user"))
          ;;  (".*") nil)

          ;; ;; In ~/mylisp, dmoccur search files recursively
          ;; ;; but if (string-match ".+.txt" filename)
          ;; ;; or (string-match ".+.el" filename) is t,
          ;; ;; the file is *not* searched.
          ;; ("ignore-txt"
          ;;  (("~/mylisp" t (".+.txt" ".+.el"))
          ;;   ("~/user"))
          ;;  (".*") nil)

          ;; ;; if option is dir (or sub),
          ;; ;; you can set single directory only.
          ;; ("dir-recursive" ((default-directory t)) (".*") dir)
          ))

  ;; ;; https://emacs.stackexchange.com/a/76040
  ;; (defun use-least-recent-window (orig-fun &rest args)
  ;;   (let ((display-buffer-alist '((".*" display-buffer-use-least-recent-window))))
  ;;     (apply orig-fun args)))
  ;; (defun moccur-view-file-before (old-fun &rest args)
  ;;   (advice-add 'switch-to-buffer-other-window :around #'use-least-recent-window)
  ;;   (apply old-fun args))
  ;; (defun moccur-view-file-after (return-value old-fun &rest args)
  ;;   (advice-remove 'switch-to-buffer-other-window  #'use-least-recent-window)
  ;;   return-value)
  ;; (advice-add 'moccur-view-file :before #'moccur-view-file-before)
  ;; (advice-add 'moccur-view-file :after  #'moccur-view-file-after)
  ;; ;; (advice-remove 'moccur-view-file #'moccur-view-file-before)
  ;; ;; (advice-remove 'moccur-view-file #'moccur-view-file-after)

  ;; curl -Lo ~/AppData/Roaming/.emacs.d/lisp/moccur-edit.el https://github.com/emacsmirror/emacswiki.org/raw/master/moccur-edit.el
  (when (locate-library "moccur-edit")
    (require 'moccur-edit)
    (defadvice moccur-edit-change-file
        (after save-after-moccur-edit-buffer activate)
      (save-buffer))
    )
  )
