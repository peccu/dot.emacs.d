;; ;; http://d.hatena.ne.jp/lpubsppop01/20130114/1358167941
;; ;; (setq exec-path (cons "c:/Apps/Python33" exec-path))
;; (autoload 'python-mode "python-mode" "Python Mode." t)
;; (add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
;; (add-to-list 'auto-mode-alist '("\\.psp\\'" . sgml-mode))
;; (add-to-list 'interpreter-mode-alist '("python" . python-mode))
;; (setq py-python-edit-version "python3")
;; (setq py-python-command "python3")
;; ;; (setq python-shell-interpreter "python3")
;; ;; (setq python-shell-interpreter "c:/Apps/Python33/python.exe")
;; (setenv "PATH" (mapconcat 'identity exec-path ";"))
;; ;; (add-hook 'python-mode-hook
;; ;;           '(lambda ()
;; ;;              (setq tab-width 8)
;; ;;              (setq python-indent 8)
;; ;;              (setq indent-tabs-mod nil)
;; ;;              ;; (setq comment-padding "	")
;; ;;              ))

;; ;; (add-hook 'python-mode-hook
;; ;;           (lambda ()
;; ;;             (setq-default indent-tabs-mode nil)
;; ;;             (setq-default tab-width 2)
;; ;;             (setq-default py-indent-tabs-mode nil)
;; ;;             ;; This overwrite globally write-file-functions...
;; ;;             ;; (add-to-list 'write-file-functions 'delete-trailing-whitespace)
;; ;;             ))

;; ;; 上下どっちが正しい？
;; (defun my-python-mode-hook ()
;;   (setq tab-width 4)
;;   (setq python-indent 4)
;;   (setq python-indent-offset 4)
;;   (setq indent-tabs-mode nil)
;;   (setq py-indent-tabs-mode nil)
;;   (setq py-indent-offset 4)
;;   ;;	(setq comment-padding "	")
;;   (setq comment-column 48)   ;コメント開始桁
;;   (define-key python-mode-map (kbd "M-RET") 'indent-to-comment-for-monotaro)
;;   ;; (setq imenu-create-index-function 'python-imenu-create-index)
;;   (setq imenu-create-index-function 'py-imenu-create-index-function)
;;   )
;; (add-hook 'python-mode-hook 'my-python-mode-hook)


;; (defun indent-to-comment-for-monotaro ()
;;   (interactive)
;;   (end-of-line)
;;   (if (< (current-column) comment-column)
;;     (progn
;;       (insert "	")
;;       (indent-to-comment-for-monotaro))
;;     (when (= (current-column) comment-column)
;;       (insert "# "))
;;     ;;	(when (> (current-column) comment-column)
;;     ;;	  (insert "# "))
;;     ;; 超えてた時に、# を大量発生させない方法がわからん
;;     ))

;; http://ylupin.blog57.fc2.com/blog-entry-9984.html
(quickrun-add-command "python"
                      '((:command . "python3")
                        (:exec . "%c %s")
                        (:compile-only . "pyflakes %s"))
                      :mode 'python-mode)

;; ;; https://pylint.readthedocs.io/en/latest/user_guide/ide-integration.html
;; ;; Configure flymake for Python
;; (when (load "flymake" t)
;;   (defun flymake-pylint-init ()
;;     (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                        'flymake-create-temp-inplace))
;;            (local-file (file-relative-name
;;                         temp-file
;;                         (file-name-directory buffer-file-name))))
;;       (list "epylint" (list local-file))))
;;   (add-to-list 'flymake-allowed-file-name-masks
;;                '("\\.py\\'" flymake-pylint-init)))

;; ;; Set as a minor mode for Python
;; ;; (add-hook 'python-mode-hook '(lambda () (flymake-mode)))
;; ;; (remove-hook 'python-mode-hook '(lambda () (flymake-mode)))
;; ;; ;; Configure to wait a bit longer after edits before starting
;; ;; (setq-default flymake-no-changes-timeout '3)

;; ;; Keymaps to navigate to the errors
;; (add-hook 'python-mode-hook '(lambda () (define-key python-mode-map (kbd "C-c f") 'flymake-goto-next-error)))
;; (add-hook 'python-mode-hook '(lambda () (define-key python-mode-map (kbd "C-c b") 'flymake-goto-prev-error)))

;; ;; ;; To avoid having to mouse hover for the error message, these functions make flymake error messages
;; ;; ;; appear in the minibuffer
;; ;; (defun show-fly-err-at-point ()
;; ;;   "If the cursor is sitting on a flymake error, display the message in the minibuffer"
;; ;;   (require 'cl)
;; ;;   (interactive)
;; ;;   (let ((line-no (line-number-at-pos)))
;; ;;     (dolist (elem flymake-err-info)
;; ;;       (if (eq (car elem) line-no)
;; ;;       (let ((err (car (second elem))))
;; ;;         (message "%s" (flymake-ler-text err)))))))

;; ;; (add-hook 'post-command-hook 'show-fly-err-at-point)
;; ;; (defadvice flymake-goto-next-error (after display-message activate compile)
;; ;;   "Display the error in the mini-buffer rather than having to mouse over it"
;; ;;   (show-fly-err-at-point))

;; ;; (defadvice flymake-goto-prev-error (after display-message activate compile)
;; ;;   "Display the error in the mini-buffer rather than having to mouse over it"
;; ;;   (show-fly-err-at-point))

;; https://realpython.com/emacs-the-best-python-editor/
(require 'elpy)
;; (elpy-enable)
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
(require 'ein)
;; M-x ein:login
;; http://topas.coreos.tgl.jp:8888/tree?
