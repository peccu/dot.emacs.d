(when (or
       peccu-p
       ;; win-env-p
       ;; wsl-p
       )
  ;; http://d.hatena.ne.jp/gom68/20090524/1243170341
  ;; (add-to-list 'load-path "~/.emacs.d/lisp/magit/share/emacs/site-lisp/")
  ;; (custom-set-variables
  ;;  '(magit-cygwin-mount-points "/usr/lib/git-core"))
  (require-with-install 'magit)
  (global-set-key (kbd "C-x g") 'magit-status)

  ;; http://www.rubyist.net/~rubikitch/junk/2010-05-25-054318.magit.logoutputencoding.el
;;; [2010/05/25]
  (defvar magit-logoutputencoding nil)
  (defun magit-encoding-string-to-symbol (encoding-str)
    (cond ((equal encoding-str "Shift_JIS")
           'sjis)
          ((equal encoding-str "EUC-JP")
           'euc-jp)
          (t
           'utf-8)))
  (defadvice magit-log (around log-encoding-set activate)
    ""
    (let* ((logoutputencoding (magit-encoding-string-to-symbol
                               (magit-get "i18n" "logoutputencoding")))
           (coding-system-for-read logoutputencoding)
           (coding-system-for-write logoutputencoding))
      ad-do-it
      (set (make-local-variable 'magit-logoutputencoding) logoutputencoding)))
  ;; (progn (ad-disable-advice 'magit-log 'after 'log-encoding-set) (ad-update 'magit-log))

  (defadvice magit-show-commit (around log-encoding-set activate)
    ""
    (let ((coding-system-for-read magit-logoutputencoding)
          (coding-system-for-write magit-logoutputencoding))
      ad-do-it))
  ;; (progn (ad-disable-advice 'magit-show-commit 'around 'log-encoding-set) (ad-update 'magit-show-commit))

  ;; ;; http://d.hatena.ne.jp/ken_m/20110602/1307006123
  ;; ;;;
  ;; ;;; log-edit.el のコメント履歴を session.el で保存する
  ;; ;;;

  ;; ;; session.el で保存するコメント履歴
  ;; (defvar my-log-edit-comment-ring nil)

  ;; ;; コメント履歴が追加された時に `log-edit-comment-ring' を session.el で保存できる形式に変換
  ;; (defadvice magit-log-edit-push-to-comment-ring (after my-store-log-edit-commment-ring activate)
  ;;   (setq my-log-edit-comment-ring (my-ring-to-list log-edit-comment-ring)))

  ;; ;; リングをリストに変換 (car にリングサイズ、cdr に要素)
  ;; (defun my-ring-to-list (ring)
  ;;   (when (ring-p ring)
  ;;     (append (list (ring-size ring)) (ring-elements ring))))

  ;; ;; `my-ring-to-list' で作成したリストをリングに変換
  ;; (defun my-list-to-ring (l &optional newsize)
  ;;   (let* ((size (if newsize newsize (car l)))
  ;;          (orgelem (append (cdr l) nil)) ; 後でリストを破壊するので append を使ってリストをコピー
  ;;          (elem (reverse (if (>= size (length orgelem))
  ;;                             orgelem
  ;;                           (setcdr (nthcdr (1- size) orgelem) nil)
  ;;                           orgelem)))
  ;;          (ring (make-ring size)))
  ;;     (while elem
  ;;       (ring-insert ring (car elem))
  ;;       (setq elem (cdr elem)))
  ;;     ring))

  ;; ;; session.el に保存したコメント履歴を log-edit.el に復元
  ;; (add-hook 'session-after-load-save-file-hook
  ;;           (lambda ()
  ;;             (when (boundp 'my-log-edit-comment-ring)
  ;;               (setq log-edit-comment-ring
  ;;                     (my-list-to-ring my-log-edit-comment-ring
  ;;                                      (when (boundp 'log-edit-comment-ring)
  ;;                                        (ring-size log-edit-comment-ring)))))))

  (require 'magit-blame)
  (defun magit-blame-this-file()
    "visit file and call magit-blame-mode"
    (interactive)
    (magit-visit-item)
    (magit-blame-mode))

  ;; moved to ediff.el
  ;; ;; http://www.clear-code.com/blog/2012/4/3.html
  ;; ;; diffの表示方法を変更
  ;; (defun diff-mode-setup-faces ()
  ;;   ;; 追加された行は緑で表示
  ;;   (set-face-attribute 'diff-added nil
  ;;                       :foreground "white" :background "dark green")
  ;;   ;; 削除された行は赤で表示
  ;;   (set-face-attribute 'diff-removed nil
  ;;                       :foreground "white" :background "dark red")
  ;;   ;; 文字単位での変更箇所は色を反転して強調
  ;;   (set-face-attribute 'diff-refine-change nil
  ;;                       :foreground nil :background nil
  ;;                       :weight 'bold :inverse-video t))
  ;; (add-hook 'diff-mode-hook 'diff-mode-setup-faces)

  ;; ;; diffを表示したらすぐに文字単位での強調表示も行う
  ;; (defun diff-mode-refine-automatically ()
  ;;   (diff-auto-refine-mode t))
  ;; (add-hook 'diff-mode-hook 'diff-mode-refine-automatically)

  ;; ;; diff関連の設定
  ;; (defun magit-setup-diff ()
  ;;   ;; diffを表示しているときに文字単位での変更箇所も強調表示する
  ;;   ;; 'allではなくtにすると現在選択中のhunkのみ強調表示する
  ;;   (setq magit-diff-refine-hunk 'all)
  ;;   ;; diff用のfaceを設定する
  ;;   (diff-mode-setup-faces)
  ;;   ;; diffの表示設定が上書きされてしまうのでハイライトを無効にする
  ;;   (set-face-attribute 'magit-item-highlight nil :inherit nil))
  ;; (add-hook 'magit-mode-hook 'magit-setup-diff)

  ;; (setq magit-git-standard-options (append magit-git-standard-options
  ;;                                          '("-c" "core.quotepath=false"
  ;;                                            "-c" "i18n.commitEncoding='utf-8'")))

  ;; stay in same window
  (custom-set-variables
   '(magit-display-buffer-function 'magit-display-buffer-same-window-except-diff-v1))

  ;; https://www.clear-code.com/blog/2012/4/3.html
  ;; https://magit.vc/manual/magit/Diff-Options.html
  (setq magit-diff-refine-hunk 'all)
  (setq magit-diff-paint-whitespace-lines 'all)
  (setq magit-diff-highlight-trailing t)
  )
