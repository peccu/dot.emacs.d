(require 'mew)
(load (concat user-emacs-directory ".mew.el"))
;; (require 'mew-send)
;; (require 'mew-user-agent-compose)
;; Optional setup (e.g. C-xm for sending a message):
(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'mew-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'mew-user-agent
      'mew-user-agent-compose
      'mew-draft-send-message
      'mew-draft-kill
      'mew-send-hook))
;; (require 'mew-multi-case-retrieve)
;; (load "mew-summary-next-unread")

(setq mew-use-unread-mark t)
(setq mew-use-cached-passwd t)
(setq mew-use-master-passwd nil)
;; (setq mew-passwd-repeat 3)
(setq mew-auto-flush-queue nil)
;; 再編集の時にケースにしたがってヘッダを置き換える
(setq mew-case-guess-when-prepared t)
;; Cでケースを設定した後に各inboxに移動する
(setq mew-visit-inbox-after-setting-case t)
;;  (setq mew-debug t)
;; summaryモードのフォーマット
(setq mew-summary-form '(type (4 year) "/" (5 date) " " (5 time) " " (80 from) "|" t (0 subj)))

;; timezoneを考慮する
;; http://permalink.gmane.org/gmane.mail.mew.general.japanese/2355
(defun mew-summary-form-time-z ()
  "A function to return a message time, HH:MM"
  (let ((s (MEW-DATE)))
    (setq s (timezone-make-date-arpa-standard
             (if (or (string= s "")
                     (not (string-match mew-time-rfc-regex s)))
                 (mew-time-ctz-to-rfc
                  (mew-file-get-time (mew-expand-folder (MEW-FLD) (MEW-NUM))))
               s)))
    (if (string-match mew-time-rfc-regex s)
        (format "%02d:%02d"
                (or (mew-time-rfc-hour) 0)
                (or (mew-time-rfc-min)  0))
      "00:00")))

(defun mew-summary-form-date-z ()
  "A function to return a date, MM/DD."
  (let ((s (MEW-DATE)))
    (setq s (timezone-make-date-arpa-standard
             (if (or (string= s "")
                     (not (string-match mew-time-rfc-regex s)))
                 (mew-time-ctz-to-rfc
                  (mew-file-get-time (mew-expand-folder (MEW-FLD) (MEW-NUM))))
               s)))
    (if (string-match mew-time-rfc-regex s)
        (format "%02d/%02d"
                (mew-time-mon-str-to-int (mew-time-rfc-mon))
                (mew-time-rfc-day))
      "")))

(defun mew-summary-form-time-zone ()
  "A function to return a message date timezone, +ZZZZ."
  (let ((s (MEW-DATE)))
    (when (or (string= s "")
              (not (string-match mew-time-rfc-regex s)))
      (setq s (mew-time-ctz-to-rfc
               (mew-file-get-time (mew-expand-msg (MEW-FLD) (MEW-NUM))))))
    (if (string-match mew-time-rfc-regex s)
        (format "%05s"
                (if (match-beginning 9)
                    (let ((tmzn (substring s (match-beginning 9) (match-end 9)))
                          int)
                      (cond
                       ((string-match "^[-+][0-9]+$" tmzn)
                        tmzn)
                       ((setq int (mew-time-tmzn-str-to-int tmzn))
                        (format "%s00" int))
                       (t "+????")))
                  "+????"))
      "+????")))

(setq mew-summary-form '(type (4 year) "/" (5 date-z) " " (5 time-z) "(" (5 time-zone) ") " (60 from) "|" t (0 subj)))

;; http://reed1200.at.infoseek.co.jp/mew/#summary_inc
;; (require 'mew-multi-case-retrieve)
;;;;;;;; (require 'mew-multi-case)
;; (require 'mew)

;; Apple Mailから送信された添付ファイルを見る
;; http://comments.gmane.org/gmane.mail.mew.general.japanese/7987
;; もしくはSummaryで:キーを押すと確認できる
(setq mew-disable-alternative-regex-list '("Apple Mail"))
(setq mew-mime-multipart-alternative-list '("Multipart/.*" "Text/Plain" "Text/Html" ".*"))

;; http://flatray.com/memo/?date=20091030
;;添付し忘れ防止 (mew-send-hook に設定してください)
(defun tenpu-wasure ()
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (let ((tenpu (search-forward "添付" (point-max) t))
          (attachments (search-forward "--- attachments ---" (point-max) t))
          (second-part (search-forward-regexp " 2  [A-Z][a-z]*/" (point-max) t)))
      (if (not (null tenpu))
          (if (not (null attachments))
              (if (not (null second-part))
                  (message "キーワード「添付」があり、添付ファイルがあります。")
                (progn
                  (setq sendok (y-or-n-p "まだ添付していません。送信しますか? "))
                  (if (not sendok)
                      (error "送信を中止しました。"))))
            (progn
              (setq sendok (y-or-n-p "添付していません。送信しますか? "))
              (if (not sendok)
                  (error "送信を中止しました。"))))
        (message "キーワード「添付」がありません。")))))
(add-hook 'mew-send-hook 'tenpu-wasure)

;; パスワードの誤送信防止
(defun includes-password-check ()
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (let ((pass (search-forward-regexp "password\\|パスワード\\|PW\\|pw\\|pass\\|PASS" (point-max) t)))
      (if (not (null pass))
          (progn
            (setq sendok (y-or-n-p "passwordが含まれているかもしれません。送信しますか? "))
            (if (not sendok)
                (error "送信を中止しました。")))
        (message "キーワード「password」がありません。")))))
(add-hook 'mew-send-hook 'includes-password-check)

;; スパムの学習
;; http://www.mew.org/ja/info/release/mew_9.html#spam2
(setq mew-spam-prog "bogofilter")
(setq mew-spam-prog-args '("-s" "-N" "-v"))
(setq mew-ham-prog "bogofilter")
(setq mew-ham-prog-args '("-n" "-S" "-v"))

(defun mew-summary-auto-or-manually-refile-region (func &optional arg)
  "refile region."
  ;; * -> $
  (mew-summary-mark-escape)
  (when (mew-mark-active-p) (setq arg t))
  (if arg
      (let ((begend (mew-summary-get-region)))
        (point-stack-push)
        (mew-summary-mark-all-region (car begend) (cdr begend))
        (funcall func)
        (mew-mark-undo-mark ?*)
        (point-stack-pop))
    (message "No region to refile"))
  ;; $ -> *
  (mew-summary-mark-review))

(defun mew-summary-auto-refile-region (&optional arg)
  "auto refile region."
  (interactive "P")
  (mew-summary-auto-or-manually-refile-region #'(lambda ()(mew-summary-auto-refile t)) arg))

(defun mew-summary-refile-region (&optional arg)
  "refile region selectively."
  (interactive "P")
  (mew-summary-auto-or-manually-refile-region #'mew-summary-mark-refile arg))

;; ;; gキーで開くときにewwを使う
;; ;; http://suzuki.tdiary.net/20140813.html
;; ;; (setq browse-url-browser-function 'browse-url-default-browser)
;; (setq browse-url-browser-function 'eww-browse-url)
;; -> browse-url.el

;; デフォルト5分おきに新着メールを確認してモードラインに表示する
;; http://www.mew.org/ja/info/release/mew_9.html#biff
;; Trampの not a tramp file nameを防ぐ
;; (setq mew-use-biff t)
;; ;; 間隔を10分に
;; (setq mew-biff-interval 10)
;; biffのタイミングで音を鳴らす
;; (setq mew-use-biff-bell t)

;; ;; 音を鳴らす関数を上書きする
;; (eval-after-load "todochiku"
;;   '(progn
;;      (defun mew-biff-bark (n)
;;        (if (= n 0)
;;            (setq mew-biff-string nil)
;;          (if (and mew-use-biff-bell (eq mew-biff-string nil))
;;              ;; まだ未読のままならここは飛ばされる
;;              (progn
;;                (todochiku-message "Mew"
;;                                   (format "メールが%d件到着しました．" n)
;;                                   'mail)
;;                (when (functionp 'ipmsg-send-message)
;;                  (ipmsg-send-message (format "You got %d mail\\(s\\)." n)))
;;                ))
;;          (setq mew-biff-string (format "Mail(%d)" n))))
;;      ))
;; (mew-biff-bark 0)
;; (mew-biff-bark 3)

;; https://gist.github.com/geodenx/8570654#file-mew-biff-el
(defvar terminal-notifier-command nil "The path to terminal-notifier.")
(setq terminal-notifier-command (executable-find "terminal-notifier"))

(defun mew-biff-bark (n)
  "Overwrite mew-biff-bark to invoke terminal-notifier to show a biff alert in MacOS X Notification Center"
  (if (= n 0)
      (setq mew-biff-string nil)
    (if (and mew-use-biff-bell (not (string= mew-biff-string (format "Mail(%d)" n))))
        (start-process "terminal-notifier"
                       nil
                       terminal-notifier-command
                       "-title" "Mew"
                       "-message" (format "メールが%d件到着しました．" n)
                       "-activate" "org.gnu.Emacs"
                       "-sender" "org.gnu.Emacs"
                       "-sound" "Default"
                       "-group" "Emacs.mew"))
    (setq mew-biff-string (format "Mail(%d)" n))))

(defun mew-biff-clear ()
  "Overwrite mew-biff-clear to remove a notification invoked by mew-biff-bark"
  (setq mew-biff-string nil)
  (start-process "terminal-notifier"
                 nil
                 terminal-notifier-command
                 "-remove" "Emacs.mew"
                 "-sender" "org.gnu.Emacs"))

;; ;; htmlメールをemacs-w3mで表示する
;; (when (require 'w3m nil t)
;;   (require 'mew-w3m)
;;   ;; 添付されている画像をインライン表示する
;;   (setq mew-w3m-auto-insert-image t)
;;   ;; 画像表示のトグル
;;   ;; C-uTで本文に含まれていない画像(URLかな？)も表示する
;;   (define-key mew-summary-mode-map "T" 'mew-w3m-view-inline-image))

;; htmlメールをewwで表示する
;; http://suzuki.tdiary.net/20140813.html#c04
(when (and (fboundp 'shr-render-region)
           ;; \\[shr-render-region] requires Emacs to be compiled with libxml2.
           (fboundp 'libxml-parse-html-region))
  (setq mew-prog-text/html 'shr-render-region)) ;; 'mew-mime-text/html-w3m
;; urlとして判断する正規表現
(setq thing-at-point-url-path-regexp
      "[^]\t\n \"'()<>[^`{}]*[^]\t\n \"'()<>[^`{}.,;]+")

;; デフォルトの署名ファイル
;; 各ケースの設定は.mew.elに
(setq mew-signature-file "~/.emacs.d/.signature")
;; 署名の自動挿入
;; http://takeno.iee.niit.ac.jp/~shige/unix/memo/unix-memo.html#20080505
(setq mew-signature-insert-last t)
;; メール作成時に署名を挿入する(新規作成、返信など共通)
;; これだと返信時に引用の前に署名がつくので、後記の設定がないと署名→引用の順になる
(add-hook 'mew-draft-mode-newdraft-hook 'mew-draft-insert-signature)
;; ;; (remove-hook 'mew-draft-mode-newdraft-hook 'mew-draft-insert-signature)
;; 引用返信は、引用前にこのフックが呼ばれる
;; 引用返信時に、先に新規作成(draftの作成)されるのでそのときに上記フックで署名が入る
;; 引用前にカーソルをヘッダの直後に移動することで、署名とヘッダの間に引用される
(add-hook 'mew-before-cite-hook
          (function (lambda ()
                      (goto-char (mew-header-end))
                      (forward-line))))

;; ;; http://www.geocities.co.jp/Hollywood-Miyuki/4902/linux_11.html
;; ;; 署名の自動挿入
;; (add-hook 'mew-draft-mode-newdraft-hook
;; (remove-hook 'mew-draft-mode-newdraft-hook
;;            (function
;;                   (lambda ()
;;                     (let ((p (point)))
;;                     (goto-char (point-max))
;;                     (insert-file mew-signature-file)
;;                     (goto-char p)))))

;; ;; 返信時に引用と署名の挿入
;; ;; http://tam5917.hatenablog.com/entry/20121222/1356135707
;; (defadvice mew-draft-mode (after my-mew-summary-reply activate)
;;   (save-excursion
;;     (mew-draft-cite)
;;     ;;(mew-draft-insert-signature)
;;     ))
;; (defadvice mew-summary-reply (after my-mew-summary-reply activate)
;;   (save-excursion
;;     ;;(mew-draft-cite)
;;     ;; (mew-draft-insert-signature)
;;     ))

;; 引用返信時にカーソルを本文の先頭に移動する
(setq mew-summary-reply-with-citation-position 'body)
;; ;; 引用返信の時に、末尾に署名をつける
;; (defadvice mew-summary-reply-with-citation (after my-mew-summary-reply activate)
;;   (save-excursion
;;     (goto-char (point-max))
;;     (mew-draft-insert-signature)))


;; ;; mewのメールからorgに記録するlispだと思う
;; (require 'org)
;; (defun sk-mew-org-windows (fld msg)
;;   (delete-other-windows)
;;   (split-window-vertically -9)
;;   (mew-summary-switch-to-folder fld)
;;   (mew-summary-search-msg msg)
;;   (mew-summary-display t)
;; )

;; (add-to-list 'org-link-abbrev-alist '("mew" . sk-mew-org-link))

;; (defun sk-mew-org-link (arg)
;;   (let ((args (split-string arg "#")))
;;     (sk-mew-org-windows (car args) (car (cdr args)))
;;     ""))

;; (defvar sk-mew-org-file "/card/org/sample.org")

;; (define-key mew-summary-mode-map "@" 'sk-mew-org-add-task)

;; (defun sk-mew-org-add-task ()
;;   "test"
;;   (interactive)
;;   (mew-summary-msg
;;    (let ((fld (mew-summary-folder-name))
;;      (msg (mew-summary-message-number)))
;;      (mew-summary-set-message-buffer fld msg)
;;      (let ((sbj (mew-header-get-value "Subject:"))
;;        (buf (get-file-buffer sk-mew-org-file)))
;;        (unless buf
;;      (setq buf (find-file sk-mew-org-file)))
;;        (switch-to-buffer buf)
;;        (sk-mew-org-windows fld msg)
;;        (set-buffer buf)
;;        (goto-char (point-min))
;;        (insert (concat "* [[mew:" fld "#" msg "][" sbj "]]\n"))
;;        (other-window -1)
;;        (goto-char (+ (point-min) 2))))))


;; (insert "delay=yes\n") をstunnelの設定ファイルに追加
(defun mew-ssl-options (case server remoteport localport tls)
  (setq server (mew-ssl-server server))
  (if (= mew-ssl-ver 3)
      (let (args)
        (setq args
              `("-c" "-f"
                "-a" ,(expand-file-name (mew-ssl-cert-directory case))
                "-d" ,(format "%s:%d" mew-ssl-localhost localport)
                "-v" ,(number-to-string (mew-ssl-verify-level case))
                "-D" "debug"
                "-P" ""
                "-r" ,(format "%s:%d" server remoteport)
                ,@mew-prog-ssl-arg))
        (if tls (setq args (cons "-n" (cons tls args))))
        args)
    (let ((file (mew-make-temp-name)))
      (with-temp-buffer
        (insert "client=yes\n")
        (if (not (eq system-type 'windows-nt))
            (insert "pid=\n"))    ; Unix only
        (insert (format "verify=%d\n" (mew-ssl-verify-level case)))
        (if (not (eq system-type 'windows-nt))
            (insert "foreground=yes\n")) ; Unix only
        (insert "delay=yes\n")
        (insert "debug=debug\n")
        (if (and mew-ssl-libwrap (or (>= mew-ssl-ver 5) (>= mew-ssl-minor-ver 45)))
            (insert "libwrap=no\n"))
        (if (and (or (>= mew-ssl-ver 5) (>= mew-ssl-minor-ver 22))
                 (not (eq system-type 'windows-nt)))
            (insert "syslog=no\n")) ; Unix only
        (insert "CApath=" (expand-file-name (mew-ssl-cert-directory case)) "\n")
        (if mew-prog-ssl-arg
            (insert mew-prog-ssl-arg))
        (insert (format "[%d]\n" localport))
        (insert (format "accept=%s:%d\n" mew-ssl-localhost localport))
        (insert (format "connect=%s:%d\n" server remoteport))
        (if tls (insert (format "protocol=%s\n" tls)))
        (insert "delay=yes\n")
        (insert "client=yes\n")
        (mew-frwlet mew-cs-dummy mew-cs-text-for-write
          ;; NEVER use call-process-region for privacy reasons
          (write-region (point-min) (point-max) file nil 'no-msg))
        (list file)))))
