(when (or
       peccu-p
       win-env-p
       ;; wsl-p
       )
  (require-with-install 'yasnippet)

  ;; ;; http://d.hatena.ne.jp/IMAKADO/20080401/1206715770
  ;; (require-with-install 'anything-c-yasnippet)
  ;; ;;スペース区切りで絞り込めるようにする デフォルトは nil
  ;; (setq anything-c-yas-space-match-any-greedy t)
  ;; ;;C-c yで起動 (同時にお使いのマイナーモードとキーバインドがかぶるかもしれません)
  ;; (global-set-key (kbd "C-c y") 'anything-c-yas-complete)
  ;; (global-set-key (kbd "C-c y") 'yas/expand)
  ;; (global-set-key (kbd "<C-TAB>") 'yas-expand) ; うまくいかず
  (global-set-key [\C-\t] 'yas-expand)
  (global-set-key (kbd "<C-tab>") 'yas-expand)

  (setq yas/root-directory (concat user-emacs-directory "snippets"))
  ;; (setq yas/root-directory "~/.emacs.d/lisp/yasnippet/snippets")
  ;; スニペットファイルを開いたときにsnippet-modeにする
  ;; http://d.hatena.ne.jp/kitokitoki/20101211/p1#20101211fn1
  (defun my-snippet-mode-on ()
    (interactive)
    (when (string-match (concat "^" (expand-file-name (car yas/root-directory))) default-directory)
      (snippet-mode)))
  (add-hook 'find-file-hook 'my-snippet-mode-on)

  (yas/load-directory yas/root-directory)
  (setq yas/snippet-dirs (list yas/root-directory))
  ;; 最下部に移動
  ;; (setq yas/prompt-functions '(yas/dropdown-prompt))
  (yas/global-mode 1)

  ;; ;; https://gist.github.com/750077
  ;; ;; yasnippet 展開中はauto-completeを止める
  ;; ;;; yasnippet and auto-complete
  ;; (defvar ac-yas-expand-autostart-backup nil "保存用")
  ;; (defun ac-yas-expand-start ()
  ;;   "yasnippet展開開始時にはACを止める"
  ;;   (setq ac-yas-expand-autostart-backup ac-auto-start)
  ;;   (setq ac-auto-start nil))
  ;; (defun ac-yas-expand-end ()
  ;;   "yasnippet展開終了時にACを再開させる"
  ;;   (setq ac-auto-start ac-yas-expand-autostart-backup))
  ;; (defun ac-yas-expand-install ()
  ;;   (interactive)
  ;;   (add-hook 'yas/before-expand-snippet-hook 'ac-yas-expand-start)
  ;;   (add-hook 'yas/after-exit-snippet-hook 'ac-yas-expand-end))
  ;; (defun ac-yas-expand-uninstall ()
  ;;   (interactive)
  ;;   (remove-hook 'yas/before-expand-snippet-hook 'ac-yas-expand-start)
  ;;   (remove-hook 'yas/after-exit-snippet-hook 'ac-yas-expand-end))
  ;; (ac-yas-expand-install)

;;; http://d.hatena.ne.jp/rubikitch/20101204/yasnippet
  ;; スニペットに↓のように書いておいて，evalすることでインライン展開する
  ;; # (yas/expand-link "header.init")$0
  (defun yas/expand-link (key)
    "Hyperlink function for yasnippet expansion."
    (delete-region (point-at-bol) (point-at-eol))
    (insert key)
    (yas/expand))
  ;; auto-insertのテンプレートを選べる
  (defun yas/expand-link-choice (&rest keys)
    "Hyperlink to select yasnippet template."
    (yas/expand-link (completing-read "Select template: " keys nil t)))
  ;; (yas/expand-link-choice "defgp" "defcm")


  ;; key-chord.elに書いている
  ;; (key-chord-define-global "ya" 'yas/expand)

  ;; フック? anything-c-yasnippetの設定に書いてあった
  ;; (add-to-list 'yas/extra-mode-hooks 'ruby-mode-hook)
  ;; (add-to-list 'yas/extra-mode-hooks 'cperl-mode-hook)
  ;; (anything 'anything-c-source-yasnippet)

  ;; (anything `((name . "Yasnippet")
  ;;     (init . (lambda ()
  ;;               (setq anything-c-yas-cur-major-mode major-mode)
  ;;               (setq anything-c-yas-selected-text (if mark-active (buffer-substring-no-properties (region-beginning) (region-end)) ""))
  ;;               (multiple-value-setq
  ;;                   (anything-c-yas-initial-input anything-c-yas-point-start anything-c-yas-point-end) (anything-c-yas-get-cmp-context)) ;return values(str point point)
  ;;               (setq anything-c-yas-cur-snippets-alist (anything-c-yas-build-cur-snippets-alist))))
  ;;     (candidates . (anything-c-yas-get-candidates anything-c-yas-cur-snippets-alist))
  ;;     (candidate-transformer . (lambda (candidates)
  ;;                                (anything-c-yas-get-transformed-list anything-c-yas-cur-snippets-alist anything-c-yas-initial-input)))
  ;;     (action . (("Insert snippet" . (lambda (template)
  ;;                                      (insert template)
  ;;                                      (yas/expand-snippet template anything-c-yas-point-start anything-c-yas-point-end)
  ;;                                      (when anything-c-yas-display-msg-after-complete
  ;;                                        (message "this snippet is bound to [ %s ]"
  ;;                                                 (anything-c-yas-get-key-by-template template anything-c-yas-cur-snippets-alist)))))
  ;;                ("Open snippet file" . (lambda (template)
  ;;                                         (anything-c-yas-find-file-snippet-by-template template)))
  ;;                ("Open snippet file other window" . (lambda (template)
  ;;                                                      (anything-c-yas-find-file-snippet-by-template template t)))
  ;;                ("Create new snippet on region" . (lambda (template)
  ;;                                                    (anything-c-yas-create-new-snippet anything-c-yas-selected-text)))
  ;;                ("Reload All Snippts" . (lambda (template)
  ;;                                          (yas/reload-all)
  ;;                                          (message "Reload All Snippts done")))
  ;;                ("Rename snippet file" . (lambda (template)
  ;;                                        (let* ((path (or (anything-c-yas-get-path-by-template template) ""))
  ;;                                               (dir (file-name-directory path))
  ;;                                               (filename (file-name-nondirectory path))
  ;;                                               (rename-to (read-string (concat "rename [" filename "] to: "))))
  ;;                                          (rename-file path (concat dir rename-to))
  ;;                                          (yas/reload-all))))
  ;;                ("Delete snippet file" . (lambda (template)
  ;;                                           (let ((path (or (anything-c-yas-get-path-by-template template) "")))
  ;;                                             (when (y-or-n-p "really delete?")
  ;;                                               (delete-file path)
  ;;                                               (yas/reload-all)))))))
  ;;     (persistent-action . (lambda (template)
  ;;                            (anything-c-yas-find-file-snippet-by-template template)))
  ;;     (match . (anything-c-yas-match))))(require 'yasnippet)

  ;; anything-c-yasnippetを使わずに、anythingっぽくできるらしい
  ;; http://d.hatena.ne.jp/sugyan/20120111/1326288445
  (defun my-yas/prompt (prompt choices &optional display-fn)
    (let* ((names (cl-loop for choice in choices
                           collect (or (and display-fn (funcall display-fn choice))
                                       choice)))
           (selected (anything-other-buffer
                      `(((name . ,(format "%s" prompt))
                         (candidates . names)
                         (action . (("Insert snippet" . (lambda (arg) arg))))))
                      "*anything yas/prompt*")))
      (if selected
          (let ((n (position selected names :test 'equal)))
            (nth n choices))
        (signal 'quit "user quit!"))))
  (custom-set-variables '(yas/prompt-functions '(my-yas/prompt)))
  ;; (setq yas/prompt-functions '(my-yas/prompt))
  ;; 2つ以上スニペットがあればanythingで選べる。1つならそれを展開する
  (global-set-key (kbd "<C-S-tab>") 'yas-insert-snippet)

  (require-with-install 'helm-c-yasnippet)
  (global-set-key (kbd "C-c C-y") 'helm-yas-complete)
  )
