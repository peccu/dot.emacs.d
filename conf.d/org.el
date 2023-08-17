;; (add-to-list 'load-path "~/.emacs.d/lisp/org/lisp/")
;; (add-to-list 'load-path "~/.emacs.d/lisp/org/contrib/babel/langs/")
;; ->melpaでelfeed-orgを入れたら入ったっぽい
;; org-modeの初期化
; (setq shell-file-name "C:/Apps/gnupack_devel-11.00/app/cygwin/cygwin/bin/bash.exe")
;; ↑0shell.elに記載しているが、どうもここに書かないとみてくれない
(require 'org-install)
;; (require 'org)
;; (require 'org-clock)
(require 'org-agenda)
;; (require 'ob)
;; (require 'org-table)
;; ;; objective-C用のorg-babelを読み込む
;; (require 'ob-objc)
;; ox-md (MarkdownExport)が読み込まれないので明示的に読み込んでおく
;; M-x org-md-convert-region-to-md すると読まれる
(eval-after-load "org"
  '(require 'ox-md nil t))
;; 拡張子がorgのファイルを開いた時，自動的にorg-modeにする
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
;; (グローバル)キーバインドの設定
(global-set-key "\C-cl" 'org-store-link)

(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
;; org-modeでの強調表示を可能にする
(add-hook 'org-mode-hook 'turn-on-font-lock)
;; 見出しの余分な*を消す
(setq org-hide-leading-stars t)
;; org-default-notes-fileのファイル名
(setq org-default-notes-file "notes.org")
;; Emacs 23 でデフォルト搭載されたモード
;;  kill-lineでvisual-line-modeかどうかチェックするので，未定義エラーを回避する
(setq visual-line-mode nil)

;; BEGIN_SRCのモード名読み替え
(add-to-list 'org-src-lang-modes '("md" . markdown))
(add-to-list 'org-src-lang-modes '("elisp" . emacs-lisp))
(add-to-list 'org-src-lang-modes '("html" . web))

(defun org-feed-parse-rdf-feed (buffer)
  "Parse BUFFER for RDF feed entries.
Returns a list of entries, with each entry a property list,
containing the properties `:guid' and `:item-full-text'."
  (let (entries beg end item guid entry)
    (with-current-buffer buffer
      (widen)
      (goto-char (point-min))
      (while (re-search-forward "<item[> ]" nil t)
        (setq beg (point)
              end (and (re-search-forward "</item>" nil t)
                       (match-beginning 0)))
        (setq item (buffer-substring beg end)
              guid (if (string-match "<link\\>.*?>\\(.*?\\)</link>" item)
                       (org-match-string-no-properties 1 item)))
        (setq entry (list :guid guid :item-full-text item))
        (push entry entries)
        (widen)
        (goto-char end))
      (nreverse entries))))

;; (setq org-feed-retrieve-method 'wget)
(setq org-feed-retrieve-method 'curl)

;; (setq org-feed-default-template "\n* %T %h\n  - %a  - %description")
(setq org-feed-save-after-adding t)
;; ;; うまくいかない
;; (add-hook org-feed-after-adding-hook
;;           '(lambda ()
;;              (start-process "terminal-notifier"
;;                             nil
;;                             terminal-notifier-command
;;                             "-title" "org-feed"
;;                             "-message feed-updated"
;;                             "-activate" "org.gnu.Emacs"
;;                             "-sender" "org.gnu.Emacs"
;;                             "-sound" "Default"
;;                             "-group" "Emacs.org-feed")
;; ))

(defadvice org-update-dblock (after widen-org-update-dblock activate)
  (widen))
;; (ad-disable-advice 'org-update-dblock 'after 'widen-org-update-dblock)

;; Org-clock
;; タイムスタンプを:LOGBOOK:にまとめる
(setq org-clock-into-drawer t)
;; \emspなどUnicode文字をエスケープせず表示する
(setq org-pretty-entities nil)
;; clock-in忘れを通知する
;; (require 'clocker)
;; (setq clocker-keep-org-file-always-visible nil)
;; (clocker-mode 1)
;; 現在の作業内容をフレームに表示する
(setq org-clock-clocked-in-display 'frame-title)

;; ;; clock-in/clock-outで通知する
;; ;; http://ichiroc.hatenablog.com/entry/2013/09/05/183649
;; ;; task viewer
;; (defvar my-org-clock-in-shell-buffer-name "*ORG-CLOCK-IN-BUFFER*")
;; (add-hook 'org-clock-in-hook '(lambda () (interactive)
;;                                 (async-shell-command (concat "taskviewer"
;;                                                              " \""
;;                                                              (format-time-string "[%H:%M] " org-clock-start-time)
;;                                                              org-clock-heading
;;                                                              "\" "
;;                                                              (number-to-string (- (display-pixel-height) 160))
;;                                                              " "
;;                                                              (number-to-string (- (display-pixel-width)  420)))
;;                                                      (get-buffer-create my-org-clock-in-shell-buffer-name))
;;                                 (delete-other-windows)))
;; (add-hook 'org-clock-out-hook '(lambda () (interactive)
;;                                  (shell-command "taskkill /im:taskviewer.exe")
;;                                  (let ((clock-process-buffer (get-buffer my-org-clock-in-shell-buffer-name)))
;;                                    (while (process-live-p
;;                                            (get-buffer-process clock-process-buffer))
;;                                      (sleep-for 1))
;;                                    (kill-buffer clock-process-buffer))))

(defun my:org-clock-out-and-save-when-exit ()
  "Save buffers and stop clocking when kill emacs."
  (when (org-clocking-p)
    (org-clock-out)
    (save-some-buffers t)))

(with-eval-after-load 'org-clock
  (add-hook 'kill-emacs-hook #'my:org-clock-out-and-save-when-exit))

;; (eval-after-load "org"

  (defun org-clock-get-sum-start ()
    "Return the time from which clock times should be counted.
This is for the currently running clock as it is displayed
in the mode line.  This function looks at the properties
LAST_REPEAT and in particular CLOCK_MODELINE_TOTAL and the
corresponding variable `org-clock-mode-line-total' and then
decides which time to use."
    (let ((cmt (or (org-entry-get nil "CLOCK_MODELINE_TOTAL" t)
                   (symbol-name org-clock-mode-line-total)))
          (lr (org-entry-get nil "LAST_REPEAT")))
      (cond
       ((equal cmt "current")
        (setq org--msg-extra "showing time in current clock instance")
        (current-time))
       ((equal cmt "today")
        (setq org--msg-extra "showing today's task time.")
        (let* ((dt (decode-time))
               (hour (nth 2 dt))
               (day (nth 3 dt)))
          (if (< hour org-extend-today-until) (setf (nth 3 dt) (1- day)))
          (setf (nth 2 dt) org-extend-today-until)
          (setq dt (append (list 0 0) (nthcdr 2 dt)))
          (apply 'encode-time dt)))
       ((or (equal cmt "all")
            (and (or (not cmt) (equal cmt "auto"))
                 (not lr)))
        (setq org--msg-extra "showing entire task time.")
        nil)
       ((or (equal cmt "repeat")
            (and (or (not cmt) (equal cmt "auto"))
                 lr))
        (setq org--msg-extra "showing task time since last repeat.")
        (if (not lr)
            nil
          (org-time-string-to-time lr)))
       (t nil))))
  ;; )

;; ;; MobileOrg
;; ;; http://takutless.blogspot.com/2011/03/mobileorg-for-android.html
;; (setq org-mobile-directory "~/Dropbox/MobileOrg")       ; MobileOrg用ディレクトリ
;; ;; http://d.hatena.ne.jp/ichiroc/20100107/1262870362
;; ;; MobileOrg で Capture (新規登録)  した内容が格納される org ファイル
;; (setq org-mobile-inbox-for-pull (concat org-directory "mobileorg.org"))
;; ;; ;; todoで使用するキーワードを定義。iPhone側で Todo を編集できるようになる
;; ;; (setq org-todo-keywords '((list "NEXT-ACTION" "WAIT" "DONE")))
;; ;; org-agenda-files に追加 これで管理するorgファイルを指定
;; ;; C-c a tで表示されるのもこのorg-agenda-filesが対象
;; (setq org-agenda-files nil)
;; (dolist (file (list "todo.org" "inbox.org" "someday.org" "notes.org" "peccul.org"))
;;   (add-to-list 'org-agenda-files (concat org-directory file)))
;; ;; ;; 主にmobileorg refile 先を指定(MobileOrg側で作成した項目を移動しやすくするだけ)
;; ;; (setq org-refile-targets '((org-agenda-files :level . 1)))
;; ;; http://d.hatena.ne.jp/kshimo69/20100511/1273562394
;; ;; こんな感じにファイルに書いておくとMobileOrgでも認識される
;; ;; #+TODO: TODO(t) WAIT(w) CALENDER(c) | DONE(d!) SOMEDAY(s) REFERENCE(r) PROJECT(p)
;; ;; #+TODO: NEW(n) ASSIGNED(a!) | FIXED(f!)
;; ;; #+TAGS: @work @home
;; ;; #+TAGS: misc buy read tel mail pc

;; Start the clock on the current item (clock-in). This inserts the CLOCK keyword together with a timestamp. If this is not the first clocking of this item, the multiple CLOCK lines will be wrapped into a :LOGBOOK: drawer (see also the variable org-clock-into-drawer). You can also overrule the setting of this variable for a subtree by setting a CLOCK_INTO_DRAWER or LOG_INTO_DRAWER property. When called with a C-u prefix argument, select the task from a list of recently clocked tasks. With two C-u C-u prefixes, clock into the task at point and mark it as the default task; the default task will then always be available with letter d when selecting a clocking task. With three C-u C-u C-u prefixes, force continuous clocking by starting the clock when the last clock stopped.
;; While the clock is running, the current clocking time is shown in the mode line, along with the title of the task. The clock time shown will be all time ever clocked for this task and its children. If the task has an effort estimate (see Effort estimates), the mode line displays the current clocking time against it1 If the task is a repeating one (see Repeated tasks), only the time since the last reset of the task 2 will be shown. More control over what time is shown can be exercised with the CLOCK_MODELINE_TOTAL property. It may have the values current to show only the current clocking instance, today to show all time clocked on this task today (see also the variable org-extend-today-until), all to include all time, or auto which is the default3.

;; http://d.hatena.ne.jp/tamura70/20100227/org
;; TODO状態
(setq org-todo-keywords
      '((sequence "TODO(t)" "DOING(n)" "WAIT(w)" "IDEA(i)" "|" "DONE(d)" "SOMEDAY(s)" "HABIT(h)" "CANCEL(c)")))
;; DONEの時刻を記録
(setq org-log-done 'time)
;; 記録しない
(setq org-log-done 'nil)
;; ;; org-habitの設定
;; (require 'org-habit)
;; (setq
;;  ;; 繰り返しの予定を2回以上表示しない
;;  org-agenda-repeating-timestamp-show-all nil
;;  ;; agenda終了時にrestore window
;;  org-agenda-restore-windows-after-quit t
;;  org-agenda-skip-deadline-if-done t
;;  org-agenda-skip-scheduled-if-done t
;;  ;; ``今日'' は28時(午前4時)まで
;;  org-extend-today-until 4
;; )
;; ;; org-rememberの設定
;; ;; -> org-capture

;; ;; for GTD
;; (setq org-agenda-custom-commands
;;       '(
;;         ;; スケジュールの入ってないタスクを表示する
;;         ("x" "Unscheduled TODO" tags-todo "-SCHEDULED>=\"<now>\"" nil)
;;         ;; TODO状態のプロジェクトを表示する
;;         ("p" "Untasked project" tags-todo "project" nil)
;;         ("h" "Office and Home Lists"
;;          (
;;           (tags-todo "@LAB")
;;           (tags-todo "@HOME")
;;           (tags-todo "research")
;;           (agenda)
;;           ) nil nil)
;;         ("d" "Daily Action List"
;;          (
;;           (agenda "" ((org-agenda-ndays 1)
;;                       (org-agenda-sorting-strategy
;;                        (quote ((agenda time-up priority-down tag-up) )))
;;                       (org-deadline-warning-days 0)
;;                       ))) nil nil)
;;         ))

;; ;; TODO状態のプロジェクトを表示する(？)
;; (setq org-stuck-projects
;;       '("+PROJECT/-DONE-SOMEDAY" ("TODO" "WAIT")))
;; ;; タグを継承しない
;; (setq org-use-tag-inheritance nil)
;; (setq org-tag-alist
;;       '(
;;         ;; where tags
;;         ("@out" .?o) ("@home" . ?h) (:newline . nil)
;;         ;; what tags
;;         ("dev" . ?d) ("research" . ?r) ("craft" . ?c) ("life" . ?l) ("gtd" . ?g) ("work" . ?w) ("event" . ?e) ("fun" . ?f) (:newline . nil)
;;         ;; GTD tags
;;         ("project" . ?p)
;;         ))

;; Refiling
(setq org-refile-targets '(;; ("todo.org" :level . 1)
                           ;; ("inbox.org" :level . 1)
                           ;; ("some.org" :level . 1)
                           ;; ("notes.org" :level . 1)
                           ("archives.org" :level . 1)))

;; ;; ditaa
;; (setq org-ditaa-jar-path "~/bin/ditaa.jar")

;; ;; http://d.hatena.ne.jp/asudofu/20111216/1324034142
;; ;; todoに点数付け
;; (require 'org-todo-ranking)

;; ;; http://twitter.com/#!/naota344/status/168671627867979777
;; ;; しかし失敗するのでバックグラウンド実行しないことにした
;; (setq org-export-run-in-background nil)
;; ;; export-to-latex用の設定
;; ;; まだここが参考になる http://d.hatena.ne.jp/tamura70/20100217/org
;; ;; コマンドの設定
;; (setq org-latex-to-pdf-process
;;       '("platex --kanji=utf8 -interaction nonstopmode %f; platex --kanji=utf8 -interaction nonstopmode %f; jbibtex -kanji=utf8 %b"; dvipdfmx %b"
;;         "platex --kanji=utf8 -interaction nonstopmode %f; platex --kanji=utf8 -interaction nonstopmode %f; dvipdfmx %b"))
;; (require 'org-latex)
(setq org-latex-to-pdf-process '("platex %b" "platex %b" "dvipdfmx %b"))
;; ;; 日付のフォーマットを変更
;; (setq org-export-latex-date-format
;;       "%Y-%m-%d")

;; ;; http://orgmode.org/manual/Conflicts.html
;; ;; http://sheephead.homelinux.org/2010/05/25/1868/
;; ;; yasnippet用の設定
;; (defun yas/org-very-safe-expand ()
;;   (let ((yas/fallback-behavior 'return-nil)) (yas/expand)))
;; (add-hook 'org-mode-hook
;;           (lambda ()
;;             ;;yasnippet (using the new org-cycle hooks)
;;             (setq ac-use-overriding-local-map t)
;;             (make-variable-frame-local 'yas/trigger-key)
;;             (setq  yas/trigger-key "TAB")
;;             (add-to-list 'org-tab-first-hook 'yas/org-very-safe-expand)
;;             (define-key yas/keymap "TAB" 'yas/next-field)))

;; (require 'org-babel-init)
;; (require 'org-babel-latex)
;; ;; デフォルトのキーバインドを無効にして必要なものだけ再定義する
;; ;; cf.http://d.hatena.ne.jp/kitokitoki/20100430/p1
(add-hook 'org-mode-hook
          (lambda()
;;             (setq org-goto-map (make-keymap))
;;             (setq org-agenda-mode-map (make-keymap))
;;             (setq org-cdlatex-mode-map (make-keymap))
;;             (setq org-exit-edit-mode-map (make-keymap))
;;             (setq org-goto-local-auto-isearch-map (make-keymap))
;;             (setq org-mode-map (make-keymap))
;;             (setq org-mouse-map (make-keymap))
;;             (setq orgstruct-mode-map (make-keymap))
;;             (setq my-org-mode-map (make-keymap))
;;             (use-local-map my-org-mode-map)
;; ;;             (org-defkey my-org-mode-map [(tab)] 'org-cycle) ;自分の使いたい設定を書きたす
;; ;;             (org-defkey my-org-mode-map "\C-c*" 'org-ctrl-c-star)
;; shift cursorはwindowの移動なので無効化
(org-defkey org-mode-map [(shift up)]          nil)
(org-defkey org-mode-map [(shift down)]        nil)
(org-defkey org-mode-map [(shift left)]        nil)
(org-defkey org-mode-map [(shift right)]       nil)
;; anythingで使うのでorg-cycle-agenda-filesをやめる
(org-defkey org-mode-map [(control ?,)]        nil)
(org-defkey org-mode-map [(control ?')]        nil)
;; for howm-create
(org-defkey org-mode-map "\C-c,"               nil)
(when org-agenda-mode-map
  (org-defkey org-agenda-mode-map "\C-c,"        nil))
            ))

;; ;; http://orgmode.org/manual/Conflicts.html
;; ;; Make windmove work in org-mode:
;; (add-hook 'org-shiftup-final-hook 'windmove-up)
;; (add-hook 'org-shiftleft-final-hook 'windmove-left)
;; (add-hook 'org-shiftdown-final-hook 'windmove-down)
;; (add-hook 'org-shiftright-final-hook 'windmove-right)

;; http://d.hatena.ne.jp/kitokitoki/20100517/p2
(add-hook 'org-mode-hook
          (lambda()
            (require 'imenu-tree)))
;; (global-set-key (kbd "M-h") 'imenu-tree)

;; ;; 以下デフォルトのキーバインド
;; ;; (setq org-goto-map (make-keymap))
;; ;; org.elより
;; (defvar org-goto-map
;;   (let ((map (make-sparse-keymap)))
;;     (let ((cmds '(isearch-forward isearch-backward kill-ring-save set-mark-command mouse-drag-region universal-argument org-occur)) cmd)
;;       (while (setq cmd (pop cmds))
;;         (substitute-key-definition cmd cmd map global-map)))
;;     (suppress-keymap map)
;;     (org-defkey map "\C-m"     'org-goto-ret)
;;     (org-defkey map [(return)] 'org-goto-ret)
;;     (org-defkey map [(left)]   'org-goto-left)
;;     (org-defkey map [(right)]  'org-goto-right)
;;     (org-defkey map [(control ?g)] 'org-goto-quit)
;;     (org-defkey map "\C-i" 'org-cycle)
;;     (org-defkey map [(tab)] 'org-cycle)
;;     (org-defkey map [(down)] 'outline-next-visible-heading)
;;     (org-defkey map [(up)] 'outline-previous-visible-heading)
;;     (if org-goto-auto-isearch           ;"Non-nil means, typing characters in org-goto starts incremental search."
;;         (if (fboundp 'define-key-after)
;;             (define-key-after map [t] 'org-goto-local-auto-isearch)
;;           nil)
;;       (org-defkey map "q" 'org-goto-quit)
;;       (org-defkey map "n" 'outline-next-visible-heading)
;;       (org-defkey map "p" 'outline-previous-visible-heading)
;;       (org-defkey map "f" 'outline-forward-same-level)
;;       (org-defkey map "b" 'outline-backward-same-level)
;;       (org-defkey map "u" 'outline-up-heading))
;;     (org-defkey map "/" 'org-occur)
;;     (org-defkey map "\C-c\C-n" 'outline-next-visible-heading)
;;     (org-defkey map "\C-c\C-p" 'outline-previous-visible-heading)
;;     (org-defkey map "\C-c\C-f" 'outline-forward-same-level)
;;     (org-defkey map "\C-c\C-b" 'outline-backward-same-level)
;;     (org-defkey map "\C-c\C-u" 'outline-up-heading)
;;     map))
;; ;; (setq org-agenda-mode-map (make-keymap))
;; ;; org-agenda.el
;; (org-defkey org-agenda-mode-map "\C-i"     'org-agenda-goto)
;; (org-defkey org-agenda-mode-map [(tab)]    'org-agenda-goto)
;; (org-defkey org-agenda-mode-map "\C-m"     'org-agenda-switch-to)
;; (org-defkey org-agenda-mode-map "\C-k"     'org-agenda-kill)
;; (org-defkey org-agenda-mode-map "\C-c\C-w" 'org-agenda-refile)
;; (org-defkey org-agenda-mode-map "m"        'org-agenda-bulk-mark)
;; (org-defkey org-agenda-mode-map "u"        'org-agenda-bulk-unmark)
;; (org-defkey org-agenda-mode-map "U"        'org-agenda-bulk-remove-all-marks)
;; (org-defkey org-agenda-mode-map "B"        'org-agenda-bulk-action)
;; (org-defkey org-agenda-mode-map "\C-c\C-x!" 'org-reload)
;; (org-defkey org-agenda-mode-map "\C-c\C-x\C-a" 'org-agenda-archive-default)
;; (org-defkey org-agenda-mode-map "\C-c\C-xa"    'org-agenda-toggle-archive-tag)
;; (org-defkey org-agenda-mode-map "\C-c\C-xA"    'org-agenda-archive-to-archive-sibling)
;; (org-defkey org-agenda-mode-map "\C-c\C-x\C-s" 'org-agenda-archive)
;; (org-defkey org-agenda-mode-map "\C-c$"        'org-agenda-archive)
;; (org-defkey org-agenda-mode-map "$"        'org-agenda-archive)
;; (org-defkey org-agenda-mode-map "\C-c\C-o" 'org-agenda-open-link)
;; (org-defkey org-agenda-mode-map " "        'org-agenda-show-and-scroll-up)
;; (org-defkey org-agenda-mode-map [backspace] 'org-agenda-show-scroll-down)
;; (org-defkey org-agenda-mode-map "\d" 'org-agenda-show-scroll-down)
;; (org-defkey org-agenda-mode-map [(control shift right)] 'org-agenda-todo-nextset)
;; (org-defkey org-agenda-mode-map [(control shift left)]  'org-agenda-todo-previousset)
;; (org-defkey org-agenda-mode-map "\C-c\C-xb" 'org-agenda-tree-to-indirect-buffer)
;; (org-defkey org-agenda-mode-map "o"        'delete-other-windows)
;; (org-defkey org-agenda-mode-map "L"        'org-agenda-recenter)
;; (org-defkey org-agenda-mode-map "\C-c\C-t" 'org-agenda-todo)
;; (org-defkey org-agenda-mode-map "t"        'org-agenda-todo)
;; (org-defkey org-agenda-mode-map "a"        'org-agenda-archive-default-with-confirmation)
;; (org-defkey org-agenda-mode-map ":"        'org-agenda-set-tags)
;; (org-defkey org-agenda-mode-map "\C-c\C-q" 'org-agenda-set-tags)
;; (org-defkey org-agenda-mode-map "."        'org-agenda-goto-today)
;; (org-defkey org-agenda-mode-map "j"        'org-agenda-goto-date)
;; (org-defkey org-agenda-mode-map "d"        'org-agenda-day-view)
;; (org-defkey org-agenda-mode-map "w"        'org-agenda-week-view)
;; (org-defkey org-agenda-mode-map "y"        'org-agenda-year-view)
;; (org-defkey org-agenda-mode-map "\C-c\C-z" 'org-agenda-add-note)
;; (org-defkey org-agenda-mode-map "z"        'org-agenda-add-note)
;; (org-defkey org-agenda-mode-map "k"        'org-agenda-action)
;; (org-defkey org-agenda-mode-map "\C-c\C-x\C-k" 'org-agenda-action)
;; (org-defkey org-agenda-mode-map [(shift right)] 'org-agenda-do-date-later)
;; (org-defkey org-agenda-mode-map [(shift left)] 'org-agenda-do-date-earlier)
;; (org-defkey org-agenda-mode-map [?\C-c ?\C-x (right)] 'org-agenda-do-date-later)
;; (org-defkey org-agenda-mode-map [?\C-c ?\C-x (left)] 'org-agenda-do-date-earlier)

;; (org-defkey org-agenda-mode-map ">" 'org-agenda-date-prompt)
;; (org-defkey org-agenda-mode-map "\C-c\C-s" 'org-agenda-schedule)
;; (org-defkey org-agenda-mode-map "\C-c\C-d" 'org-agenda-deadline)
;; (let ((l '(1 2 3 4 5 6 7 8 9 0)))
;;   (while l (org-defkey org-agenda-mode-map
;;                        (int-to-string (pop l)) 'digit-argument)))

;; (org-defkey org-agenda-mode-map "F" 'org-agenda-follow-mode)
;; (org-defkey org-agenda-mode-map "R" 'org-agenda-clockreport-mode)
;; (org-defkey org-agenda-mode-map "E" 'org-agenda-entry-text-mode)
;; (org-defkey org-agenda-mode-map "l" 'org-agenda-log-mode)
;; (org-defkey org-agenda-mode-map "v" 'org-agenda-view-mode-dispatch)
;; (org-defkey org-agenda-mode-map "D" 'org-agenda-toggle-diary)
;; (org-defkey org-agenda-mode-map "G" 'org-agenda-toggle-time-grid)
;; (org-defkey org-agenda-mode-map "r" 'org-agenda-redo)
;; (org-defkey org-agenda-mode-map "g" 'org-agenda-redo)
;; (org-defkey org-agenda-mode-map "e" 'org-agenda-set-effort)
;; (org-defkey org-agenda-mode-map "\C-c\C-xe" 'org-agenda-set-effort)
;; (org-defkey org-agenda-mode-map "\C-c\C-x\C-e"
;;             'org-clock-modify-effort-estimate)
;; (org-defkey org-agenda-mode-map "\C-c\C-xp" 'org-agenda-set-property)
;; (org-defkey org-agenda-mode-map "q" 'org-agenda-quit)
;; (org-defkey org-agenda-mode-map "x" 'org-agenda-exit)
;; (org-defkey org-agenda-mode-map "\C-x\C-w" 'org-write-agenda)
;; (org-defkey org-agenda-mode-map "\C-x\C-s" 'org-save-all-org-buffers)
;; (org-defkey org-agenda-mode-map "s" 'org-save-all-org-buffers)
;; (org-defkey org-agenda-mode-map "P" 'org-agenda-show-priority)
;; (org-defkey org-agenda-mode-map "T" 'org-agenda-show-tags)
;; (org-defkey org-agenda-mode-map "n" 'org-agenda-next-line)
;; (org-defkey org-agenda-mode-map "p" 'org-agenda-previous-line)
;; (substitute-key-definition 'next-line 'org-agenda-next-line
;;                            org-agenda-mode-map global-map)
;; (substitute-key-definition 'previous-line 'org-agenda-previous-line
;;                            org-agenda-mode-map global-map)
;; (org-defkey org-agenda-mode-map "\C-c\C-a" 'org-attach)
;; (org-defkey org-agenda-mode-map "\C-c\C-n" 'org-agenda-next-date-line)
;; (org-defkey org-agenda-mode-map "\C-c\C-p" 'org-agenda-previous-date-line)
;; (org-defkey org-agenda-mode-map "," 'org-agenda-priority)
;; (org-defkey org-agenda-mode-map "\C-c," 'org-agenda-priority)
;; (org-defkey org-agenda-mode-map "i" 'org-agenda-diary-entry)
;; (org-defkey org-agenda-mode-map "c" 'org-agenda-goto-calendar)
;; (org-defkey org-agenda-mode-map "C" 'org-agenda-convert-date)
;; (org-defkey org-agenda-mode-map "M" 'org-agenda-phases-of-moon)
;; (org-defkey org-agenda-mode-map "S" 'org-agenda-sunrise-sunset)
;; (org-defkey org-agenda-mode-map "h" 'org-agenda-holidays)
;; (org-defkey org-agenda-mode-map "H" 'org-agenda-holidays)
;; (org-defkey org-agenda-mode-map "\C-c\C-x\C-i" 'org-agenda-clock-in)
;; (org-defkey org-agenda-mode-map "I" 'org-agenda-clock-in)
;; (org-defkey org-agenda-mode-map "\C-c\C-x\C-o" 'org-agenda-clock-out)
;; (org-defkey org-agenda-mode-map "O" 'org-agenda-clock-out)
;; (org-defkey org-agenda-mode-map "\C-c\C-x\C-x" 'org-agenda-clock-cancel)
;; (org-defkey org-agenda-mode-map "X" 'org-agenda-clock-cancel)
;; (org-defkey org-agenda-mode-map "\C-c\C-x\C-j" 'org-clock-goto)
;; (org-defkey org-agenda-mode-map "J" 'org-clock-goto)
;; (org-defkey org-agenda-mode-map "+" 'org-agenda-priority-up)
;; (org-defkey org-agenda-mode-map "-" 'org-agenda-priority-down)
;; (org-defkey org-agenda-mode-map [(shift up)] 'org-agenda-priority-up)
;; (org-defkey org-agenda-mode-map [(shift down)] 'org-agenda-priority-down)
;; (org-defkey org-agenda-mode-map [?\C-c ?\C-x (up)] 'org-agenda-priority-up)
;; (org-defkey org-agenda-mode-map [?\C-c ?\C-x (down)] 'org-agenda-priority-down)
;; (org-defkey org-agenda-mode-map "f" 'org-agenda-later)
;; (org-defkey org-agenda-mode-map "b" 'org-agenda-earlier)
;; (org-defkey org-agenda-mode-map "\C-c\C-x\C-c" 'org-agenda-columns)
;; (org-defkey org-agenda-mode-map "\C-c\C-x>" 'org-agenda-remove-restriction-lock)

;; (org-defkey org-agenda-mode-map "[" 'org-agenda-manipulate-query-add)
;; (org-defkey org-agenda-mode-map "]" 'org-agenda-manipulate-query-subtract)
;; (org-defkey org-agenda-mode-map "{" 'org-agenda-manipulate-query-add-re)
;; (org-defkey org-agenda-mode-map "}" 'org-agenda-manipulate-query-subtract-re)
;; (org-defkey org-agenda-mode-map "/" 'org-agenda-filter-by-tag)
;; (org-defkey org-agenda-mode-map "\\" 'org-agenda-filter-by-tag-refine)
;; (org-defkey org-agenda-mode-map ";" 'org-timer-set-timer)
;; (define-key org-agenda-mode-map "?" 'org-agenda-show-the-flagging-note)
;; (org-defkey org-agenda-mode-map "\C-c\C-x\C-mg"    'org-mobile-pull)
;; (org-defkey org-agenda-mode-map "\C-c\C-x\C-mp"    'org-mobile-push)

;; (org-defkey org-agenda-mode-map
;;             (if (featurep 'xemacs) [(button2)] [(mouse-2)]) 'org-agenda-goto-mouse)
;; (org-defkey org-agenda-mode-map
;;             (if (featurep 'xemacs) [(button3)] [(mouse-3)]) 'org-agenda-show-mouse)
;; (when org-agenda-mouse-1-follows-link
;;   (org-defkey org-agenda-mode-map [follow-link] 'mouse-face))

;; ;; (setq org-cdlatex-mode-map (make-keymap))
;; ;; org.el
;; (org-defkey org-cdlatex-mode-map "_" 'org-cdlatex-underscore-caret)
;; (org-defkey org-cdlatex-mode-map "^" 'org-cdlatex-underscore-caret)
;; (org-defkey org-cdlatex-mode-map "`" 'cdlatex-math-symbol)
;; (org-defkey org-cdlatex-mode-map "'" 'org-cdlatex-math-modify)
;; (org-defkey org-cdlatex-mode-map "\C-c{" 'cdlatex-environment)

;; ;; (setq org-exit-edit-mode-map (make-keymap))
;; ;; nothing

;; ;; (setq org-goto-local-auto-isearch-map (make-keymap))
;; ;; org.el
;; (define-key org-goto-local-auto-isearch-map "\C-i" 'isearch-other-control-char)
;; (define-key org-goto-local-auto-isearch-map "\C-m" 'isearch-other-control-char)

;; ;; (setq org-mode-map (make-keymap))
;; ;; org.el
;; ;; Make `C-c C-x' a prefix key
;; (org-defkey org-mode-map "\C-c\C-x" (make-sparse-keymap))

;; ;; TAB key with modifiers
;; (org-defkey org-mode-map "\C-i"       'org-cycle)
;; (org-defkey org-mode-map [(tab)]      'org-cycle)
;; (org-defkey org-mode-map [(control tab)] 'org-force-cycle-archived)
;; (org-defkey org-mode-map [(meta tab)] 'org-complete)
;; (org-defkey org-mode-map "\M-\t" 'org-complete)
;; (org-defkey org-mode-map "\M-\C-i"      'org-complete)
;; ;; The following line is necessary under Suse GNU/Linux
;; (unless (featurep 'xemacs)
;;   (org-defkey org-mode-map [S-iso-lefttab]  'org-shifttab))
;; (org-defkey org-mode-map [(shift tab)]    'org-shifttab)
;; (define-key org-mode-map [backtab] 'org-shifttab)

;; (org-defkey org-mode-map [(shift return)]   'org-table-copy-down)
;; (org-defkey org-mode-map [(meta shift return)] 'org-insert-todo-heading)
;; (org-defkey org-mode-map [(meta return)]       'org-meta-return)

;; ;; Cursor keys with modifiers
;; (org-defkey org-mode-map [(meta left)]  'org-metaleft)
;; (org-defkey org-mode-map [(meta right)] 'org-metaright)
;; (org-defkey org-mode-map [(meta up)]    'org-metaup)
;; (org-defkey org-mode-map [(meta down)]  'org-metadown)

;; (org-defkey org-mode-map [(meta shift left)]   'org-shiftmetaleft)
;; (org-defkey org-mode-map [(meta shift right)]  'org-shiftmetaright)
;; (org-defkey org-mode-map [(meta shift up)]     'org-shiftmetaup)
;; (org-defkey org-mode-map [(meta shift down)]   'org-shiftmetadown)

;; (org-defkey org-mode-map [(shift up)]          'org-shiftup)
;; (org-defkey org-mode-map [(shift down)]        'org-shiftdown)
;; (org-defkey org-mode-map [(shift left)]        'org-shiftleft)
;; (org-defkey org-mode-map [(shift right)]       'org-shiftright)

;; (org-defkey org-mode-map [(control shift right)] 'org-shiftcontrolright)
;; (org-defkey org-mode-map [(control shift left)]  'org-shiftcontrolleft)

;; ;;; Extra keys for tty access.
;; ;;  We only set them when really needed because otherwise the
;; ;;  menus don't show the simple keys

;; (when (or org-use-extra-keys
;;           (featurep 'xemacs) ;; because XEmacs supports multi-device stuff
;;           (not window-system))
;;   (org-defkey org-mode-map "\C-c\C-xc"    'org-table-copy-down)
;;   (org-defkey org-mode-map "\C-c\C-xM"    'org-insert-todo-heading)
;;   (org-defkey org-mode-map "\C-c\C-xm"    'org-meta-return)
;;   (org-defkey org-mode-map [?\e (return)] 'org-meta-return)
;;   (org-defkey org-mode-map [?\e (left)]   'org-metaleft)
;;   (org-defkey org-mode-map "\C-c\C-xl"    'org-metaleft)
;;   (org-defkey org-mode-map [?\e (right)]  'org-metaright)
;;   (org-defkey org-mode-map "\C-c\C-xr"    'org-metaright)
;;   (org-defkey org-mode-map [?\e (up)]     'org-metaup)
;;   (org-defkey org-mode-map "\C-c\C-xu"    'org-metaup)
;;   (org-defkey org-mode-map [?\e (down)]   'org-metadown)
;;   (org-defkey org-mode-map "\C-c\C-xd"    'org-metadown)
;;   (org-defkey org-mode-map "\C-c\C-xL"    'org-shiftmetaleft)
;;   (org-defkey org-mode-map "\C-c\C-xR"    'org-shiftmetaright)
;;   (org-defkey org-mode-map "\C-c\C-xU"    'org-shiftmetaup)
;;   (org-defkey org-mode-map "\C-c\C-xD"    'org-shiftmetadown)
;;   (org-defkey org-mode-map [?\C-c (up)]    'org-shiftup)
;;   (org-defkey org-mode-map [?\C-c (down)]  'org-shiftdown)
;;   (org-defkey org-mode-map [?\C-c (left)]  'org-shiftleft)
;;   (org-defkey org-mode-map [?\C-c (right)] 'org-shiftright)
;;   (org-defkey org-mode-map [?\C-c ?\C-x (right)] 'org-shiftcontrolright)
;;   (org-defkey org-mode-map [?\C-c ?\C-x (left)] 'org-shiftcontrolleft)
;;   (org-defkey org-mode-map [?\e (tab)] 'org-complete)
;;   (org-defkey org-mode-map [?\e (shift return)] 'org-insert-todo-heading)
;;   (org-defkey org-mode-map [?\e (shift left)]   'org-shiftmetaleft)
;;   (org-defkey org-mode-map [?\e (shift right)]  'org-shiftmetaright)
;;   (org-defkey org-mode-map [?\e (shift up)]     'org-shiftmetaup)
;;   (org-defkey org-mode-map [?\e (shift down)]   'org-shiftmetadown))

;; ;; All the other keys

;; (org-defkey org-mode-map "\C-c\C-a" 'show-all) ; in case allout messed up.
;; (org-defkey org-mode-map "\C-c\C-r" 'org-reveal)
;; (if (boundp 'narrow-map)
;;     (org-defkey narrow-map "s" 'org-narrow-to-subtree)
;;   (org-defkey org-mode-map "\C-xns" 'org-narrow-to-subtree))
;; (org-defkey org-mode-map "\C-c\C-f"    'org-forward-same-level)
;; (org-defkey org-mode-map "\C-c\C-b"    'org-backward-same-level)
;; (org-defkey org-mode-map "\C-c$"    'org-archive-subtree)
;; (org-defkey org-mode-map "\C-c\C-x\C-s" 'org-advertized-archive-subtree)
;; (org-defkey org-mode-map "\C-c\C-x\C-a" 'org-archive-subtree-default)
;; (org-defkey org-mode-map "\C-c\C-xa" 'org-toggle-archive-tag)
;; (org-defkey org-mode-map "\C-c\C-xA" 'org-archive-to-archive-sibling)
;; (org-defkey org-mode-map "\C-c\C-xb" 'org-tree-to-indirect-buffer)
;; (org-defkey org-mode-map "\C-c\C-j" 'org-goto)
;; (org-defkey org-mode-map "\C-c\C-t" 'org-todo)
;; (org-defkey org-mode-map "\C-c\C-q" 'org-set-tags-command)
;; (org-defkey org-mode-map "\C-c\C-s" 'org-schedule)
;; (org-defkey org-mode-map "\C-c\C-d" 'org-deadline)
;; (org-defkey org-mode-map "\C-c;"    'org-toggle-comment)
;; (org-defkey org-mode-map "\C-c\C-v" 'org-show-todo-tree)
;; (org-defkey org-mode-map "\C-c\C-w" 'org-refile)
;; (org-defkey org-mode-map "\C-c/"    'org-sparse-tree) ; Minor-mode reserved
;; (org-defkey org-mode-map "\C-c\\"   'org-match-sparse-tree) ; Minor-mode res.
;; (org-defkey org-mode-map "\C-c\C-m" 'org-ctrl-c-ret)
;; (org-defkey org-mode-map "\M-\C-m"  'org-insert-heading)
;; (org-defkey org-mode-map "\C-c\C-xc" 'org-clone-subtree-with-time-shift)
;; (org-defkey org-mode-map [(control return)] 'org-insert-heading-respect-content)
;; (org-defkey org-mode-map [(shift control return)] 'org-insert-todo-heading-respect-content)
;; (org-defkey org-mode-map "\C-c\C-x\C-n" 'org-next-link)
;; (org-defkey org-mode-map "\C-c\C-x\C-p" 'org-previous-link)
;; (org-defkey org-mode-map "\C-c\C-l" 'org-insert-link)
;; (org-defkey org-mode-map "\C-c\C-o" 'org-open-at-point)
;; (org-defkey org-mode-map "\C-c%"    'org-mark-ring-push)
;; (org-defkey org-mode-map "\C-c&"    'org-mark-ring-goto)
;; (org-defkey org-mode-map "\C-c\C-z" 'org-add-note) ; Alternative binding
;; (org-defkey org-mode-map "\C-c."    'org-time-stamp) ; Minor-mode reserved
;; (org-defkey org-mode-map "\C-c!"    'org-time-stamp-inactive) ; Minor-mode r.
;; (org-defkey org-mode-map "\C-c,"    'org-priority) ; Minor-mode reserved
;; (org-defkey org-mode-map "\C-c\C-y" 'org-evaluate-time-range)
;; (org-defkey org-mode-map "\C-c>"    'org-goto-calendar)
;; (org-defkey org-mode-map "\C-c<"    'org-date-from-calendar)
;; (org-defkey org-mode-map [(control ?,)]     'org-cycle-agenda-files)
;; (org-defkey org-mode-map [(control ?\')]     'org-cycle-agenda-files)
;; (org-defkey org-mode-map "\C-c["    'org-agenda-file-to-front)
;; (org-defkey org-mode-map "\C-c]"    'org-remove-file)
;; (org-defkey org-mode-map "\C-c\C-x<" 'org-agenda-set-restriction-lock)
;; (org-defkey org-mode-map "\C-c\C-x>" 'org-agenda-remove-restriction-lock)
;; (org-defkey org-mode-map "\C-c-"    'org-ctrl-c-minus)
;; (org-defkey org-mode-map "\C-c*"    'org-ctrl-c-star)
;; (org-defkey org-mode-map "\C-c^"    'org-sort)
;; (org-defkey org-mode-map "\C-c\C-c" 'org-ctrl-c-ctrl-c)
;; (org-defkey org-mode-map "\C-c\C-k" 'org-kill-note-or-show-branches)
;; (org-defkey org-mode-map "\C-c#"    'org-update-statistics-cookies)
;; (org-defkey org-mode-map "\C-m"     'org-return)
;; (org-defkey org-mode-map "\C-j"     'org-return-indent)
;; (org-defkey org-mode-map "\C-c?"    'org-table-field-info)
;; (org-defkey org-mode-map "\C-c "    'org-table-blank-field)
;; (org-defkey org-mode-map "\C-c+"    'org-table-sum)
;; (org-defkey org-mode-map "\C-c="    'org-table-eval-formula)
;; (org-defkey org-mode-map "\C-c'"    'org-edit-special)
;; (org-defkey org-mode-map "\C-c`"    'org-table-edit-field)
;; (org-defkey org-mode-map "\C-c|"    'org-table-create-or-convert-from-region)
;; (org-defkey org-mode-map [(control ?#)] 'org-table-rotate-recalc-marks)
;; (org-defkey org-mode-map "\C-c~"    'org-table-create-with-table.el)
;; (org-defkey org-mode-map "\C-c\C-a" 'org-attach)
;; (org-defkey org-mode-map "\C-c}"    'org-table-toggle-coordinate-overlays)
;; (org-defkey org-mode-map "\C-c{"    'org-table-toggle-formula-debugger)
;;  (org-defkey org-mode-map "\C-c\C-e" 'org-export)
;; (org-defkey org-mode-map "\C-c:"    'org-toggle-fixed-width-section)
;; (org-defkey org-mode-map "\C-c\C-x\C-f" 'org-emphasize)
;; (org-defkey org-mode-map "\C-c\C-xf"    'org-footnote-action)
;; (org-defkey org-mode-map "\C-c\C-x\C-mg"    'org-mobile-pull)
;; (org-defkey org-mode-map "\C-c\C-x\C-mp"    'org-mobile-push)
;; (org-defkey org-mode-map [?\C-c (control ?*)] 'org-list-make-subtree)
;; ;;(org-defkey org-mode-map [?\C-c (control ?-)] 'org-list-make-list-from-subtree)

;; (org-defkey org-mode-map "\C-c\C-x\C-k" 'org-mark-entry-for-agenda-action)
;; (org-defkey org-mode-map "\C-c\C-x\C-w" 'org-cut-special)
;; (org-defkey org-mode-map "\C-c\C-x\M-w" 'org-copy-special)
;; (org-defkey org-mode-map "\C-c\C-x\C-y" 'org-paste-special)

;; (org-defkey org-mode-map "\C-c\C-x\C-t" 'org-toggle-time-stamp-overlays)
;; (org-defkey org-mode-map "\C-c\C-x\C-i" 'org-clock-in)
;; (org-defkey org-mode-map "\C-c\C-x\C-o" 'org-clock-out)
;; (org-defkey org-mode-map "\C-c\C-x\C-j" 'org-clock-goto)
;; (org-defkey org-mode-map "\C-c\C-x\C-x" 'org-clock-cancel)
;; (org-defkey org-mode-map "\C-c\C-x\C-d" 'org-clock-display)
;; (org-defkey org-mode-map "\C-c\C-x\C-r" 'org-clock-report)
;; (org-defkey org-mode-map "\C-c\C-x\C-u" 'org-dblock-update)
;; (org-defkey org-mode-map "\C-c\C-x\C-l" 'org-preview-latex-fragment)
;; (org-defkey org-mode-map "\C-c\C-x\C-b" 'org-toggle-checkbox)
;; (org-defkey org-mode-map "\C-c\C-xp"    'org-set-property)
;; (org-defkey org-mode-map "\C-c\C-xe"    'org-set-effort)
;; (org-defkey org-mode-map "\C-c\C-xo"    'org-toggle-ordered-property)
;; (org-defkey org-mode-map "\C-c\C-xi"    'org-insert-columns-dblock)
;; (org-defkey org-mode-map [(control ?c) (control ?x) ?\;] 'org-timer-set-timer)

;; (org-defkey org-mode-map "\C-c\C-x."    'org-timer)
;; (org-defkey org-mode-map "\C-c\C-x-"    'org-timer-item)
;; (org-defkey org-mode-map "\C-c\C-x0"    'org-timer-start)
;; (org-defkey org-mode-map "\C-c\C-x,"    'org-timer-pause-or-continue)

;; (define-key org-mode-map "\C-c\C-x\C-c" 'org-columns)

;; (define-key org-mode-map "\C-c\C-x!" 'org-reload)

;; (define-key org-mode-map "\C-c\C-xg" 'org-feed-update-all)
;; (define-key org-mode-map "\C-c\C-xG" 'org-feed-goto-inbox)

;; (define-key org-mode-map "\C-c\C-x[" 'org-reftex-citation)

;; ;; (setq org-mouse-map (make-keymap))
;; ;; org.el
;; (org-defkey org-mouse-map
;;             (if (featurep 'xemacs) [button2] [mouse-2]) 'org-open-at-mouse)
;; (org-defkey org-mouse-map
;;             (if (featurep 'xemacs) [button3] [mouse-3]) 'org-find-file-at-mouse)
;; (when org-mouse-1-follows-link
;;   (org-defkey org-mouse-map [follow-link] 'mouse-face))
;; (when org-tab-follows-link
;;   (org-defkey org-mouse-map [(tab)] 'org-open-at-point)
;;   (org-defkey org-mouse-map "\C-i" 'org-open-at-point))

;; ;; (setq orgstruct-mode-map (make-keymap))
;; ;; org.el
;; (defun orgstruct-setup ()
;;   "Setup orgstruct keymaps."
;;   (let ((nfunc 0)
;;         (bindings
;;          (list
;;           '([(meta up)]           org-metaup)
;;           '([(meta down)]         org-metadown)
;;           '([(meta left)]         org-metaleft)
;;           '([(meta right)]        org-metaright)
;;           '([(meta shift up)]     org-shiftmetaup)
;;           '([(meta shift down)]   org-shiftmetadown)
;;           '([(meta shift left)]   org-shiftmetaleft)
;;           '([(meta shift right)]  org-shiftmetaright)
;;           '([?\e (up)]            org-metaup)
;;           '([?\e (down)]          org-metadown)
;;           '([?\e (left)]          org-metaleft)
;;           '([?\e (right)]         org-metaright)
;;           '([?\e (shift up)]      org-shiftmetaup)
;;           '([?\e (shift down)]    org-shiftmetadown)
;;           '([?\e (shift left)]    org-shiftmetaleft)
;;           '([?\e (shift right)]   org-shiftmetaright)
;;           '([(shift up)]          org-shiftup)
;;           '([(shift down)]        org-shiftdown)
;;           '([(shift left)]        org-shiftleft)
;;           '([(shift right)]       org-shiftright)
;;           '("\C-c\C-c"            org-ctrl-c-ctrl-c)
;;           '("\M-q"                fill-paragraph)
;;           '("\C-c^"               org-sort)
;;           '("\C-c-"               org-cycle-list-bullet)))
;;         elt key fun cmd)
;;     (while (setq elt (pop bindings))
;;       (setq nfunc (1+ nfunc))
;;       (setq key (org-key (car elt))
;;             fun (nth 1 elt)
;;             cmd (orgstruct-make-binding fun nfunc key))
;;       (org-defkey orgstruct-mode-map key cmd))

;;     ;; Special treatment needed for TAB and RET
;;     (org-defkey orgstruct-mode-map [(tab)]
;;                 (orgstruct-make-binding 'org-cycle 102 [(tab)] "\C-i"))
;;     (org-defkey orgstruct-mode-map "\C-i"
;;                 (orgstruct-make-binding 'org-cycle 103 "\C-i" [(tab)]))

;;     (org-defkey orgstruct-mode-map "\M-\C-m"
;;                 (orgstruct-make-binding 'org-insert-heading 105
;;                                         "\M-\C-m" [(meta return)]))
;;     (org-defkey orgstruct-mode-map [(meta return)]
;;                 (orgstruct-make-binding 'org-insert-heading 106
;;                                         [(meta return)] "\M-\C-m"))

;;     (org-defkey orgstruct-mode-map [(shift meta return)]
;;                 (orgstruct-make-binding 'org-insert-todo-heading 107
;;                                         [(meta return)] "\M-\C-m"))

;;     (org-defkey orgstruct-mode-map "\e\C-m"
;;                 (orgstruct-make-binding 'org-insert-heading 108
;;                                         "\e\C-m" [?\e (return)]))
;;     (org-defkey orgstruct-mode-map [?\e (return)]
;;                 (orgstruct-make-binding 'org-insert-heading 109
;;                                         [?\e (return)] "\e\C-m"))
;;     (org-defkey orgstruct-mode-map [?\e (shift return)]
;;                 (orgstruct-make-binding 'org-insert-todo-heading 110
;;                                         [?\e (return)] "\e\C-m"))

;; ;; http://gist.github.com/509761
;; (require 'org-html5presentation)
;; (setq org-export-html5presentation-inline-image-extensions '("png" "jpeg" "jpg" "gif" "svg" "pdf"))
;; ;; org-export-html5presentation-inline-imagesがmaybeなのでdescriptionを空にすればインラインに画像を出力してくれる


;; ;; http://d.hatena.ne.jp/rubikitch/20100819/org
;; (require 'org-capture)
;; (defun org-capture-demo ()
;;   (interactive)
;;   (let ((file "/tmp/org-capture.org")
;;         org-capture-templates)
;;     (find-file-other-window file)
;;     (unless (save-excursion
;;               (goto-char 1)
;;               (search-forward "* test\n" nil t))
;;       (insert "* test\n** entry\n"))
;;     (other-window 1)
;;     (setq org-capture-templates
;;           `(("a" "ふつうのエントリー後に追加" entry
;;              (file+headline ,file "entry")
;;              "* %?\n%U\n%a\n")
;;             ("b" "ふつうのエントリー前に追加" entry
;;              (file+headline ,file "entry")
;;              "* %?\n%U\n%a\n" :prepend t)
;;             ("c" "即座に書き込み" entry
;;              (file+headline ,file "entry")
;;              "* immediate-finish\n" :immediate-finish t)
;;             ("d" "ナローイングしない" entry
;;              (file+headline ,file "entry")
;;              "* 全体を見る\n\n" :unnarrowed t)
;;             ("e" "クロック中のエントリに追加" entry (clock)
;;              "* clocking" :unnarrowed t)
;;             ("f" "リスト" item
;;              (file+headline ,file "list")
;;              "- リスト")
;;             ;; うまく動かない
;;             ("g" "チェックリスト" checkitem
;;              (file+headline ,file "list")
;;              "チェックリスト")
;;             ("h" "表の行" table-line
;;              (file+headline ,file "table")
;;              "|表|")
;;             ("i" "そのまま" plain
;;              (file+headline ,file "plain")
;;              "あいうえお")
;;             ("j" "ノードをフルパス指定して挿入" entry
;;              (file+olp ,file "test" "entry")
;;              "* %?\n%U\n%a\n")
;;             ;; これもうまく動かない
;;             ("k" "ノードを正規表現指定して挿入" entry
;;              (file+regexp ,file "list")
;;              "* %?\n%U\n%a\n")
;;             ;; 年月日エントリは追記される
;;             ("l" "年/月/日のエントリを作成する1" entry
;;              (file+datetree ,file))
;;             ("m" "年/月/日のエントリを作成する2" item
;;              (file+datetree ,file))
;;             ("o" "年/月/日のエントリを作成する prepend" entry
;;              (file+datetree ,file) "* a" :prepend t)))
;;     (org-capture)))

;; ;; (define-key global-map "\C-cc" 'org-capture)
;; (setq org-capture-templates
;;       '(
;;         ;; from org-remember
;;         ("r" "Note" entry (file+headline "inbox.org" "Inbox")
;;          "* %? %^g\n  %U")
;;         ("c" "Collect" entry (file+headline "inbox.org" "Inbox")
;;          "* %i%?\n  %U\n  %a")
;;         ("t" "Todo" entry (file+headline "todo.org" "Taskes Inbox")
;;          "* TODO %?%^g\n   Added: %U")
;;         ("n" "Note" entry (file+headline "notes.org" "Notes")
;;          "\n* %U %^{トピックス} %^g \n%i%?\n %a")

;;         ;; http://d.hatena.ne.jp/rubikitch/20100819/org
;;         ("e" "クロック中のエントリに追加" entry (clock)
;;          "* clocking memo%U\n %?\n Capture:%i" :unnarrowed t)

;;         ;; http://skalldan.wordpress.com/2011/07/16/色々-org-capture-する-2/
;;         ("t" "Todo" entry (file+headline "todo.org" "Taskes Inbox")
;;          "* TODO %?\n %i\n %a")
;;         ("j" "Journal" entry (file+datetree "notes.org" "Journal")
;;          "* %?\n %U\n %i\n %a")
;;         ;; for bibtex
;;         ("a" "Article" entry (file+headline "notes.org" "Articles")
;;          "* %A\n Ref. on %U\n %:author [%:year]: %:title\n
;;                                    In %:journal, pp. %:pages.\n Comment: %?")
;;         ("b" "Book" entry (file+headline "notes.org" "Books")
;;          "* %A\n Ref. on %U\n %:author [%:year]: %:title\n Comment: %?")
;;         ;; http://blogs.openaether.org/?p=236
;;         ("f" "Bookmark(Firefox)" entry (file+datetree "notes.org")
;;          "* %(concat \"[[\" (jk/moz-url) \"][\" (jk/moz-title) \"]]\")\n Entered on %U\n")

;;         ;; http://hpcgi1.nifty.com/spen/index.cgi?OrgMode%252fRememberModeTutorial#i15
;;         ("d" "Daily Review" entry (file+headline "notes.org" "Daily Journal")
;;          "* %t :COACH: \n%[~/.emacs.d/.daily_review.txt]\n")
;;         ("w" "Weekly Review" entry (file+headline "notes.org" "Weekly Journal")
;;          "* %t :COACH: \n** ステップ1 「収集」\n%[~/.emacs.d/.trigger_review.txt]\n%[~/.emacs.d/.weekly_review.txt]\n")
;;         ))
;; ;;   %[pathname] insert the contents of the file given by `pathname'.
;; ;;   %(sexp)     evaluate elisp `(sexp)' and replace with the result.
;; ;;   %<...>      the result of format-time-string on the ... format specification.
;; ;;   %t          time stamp, date only.
;; ;;   %T          time stamp with date and time.
;; ;;   %u, %U      like the above, but inactive time stamps.
;; ;;   %a          annotation, normally the link created with `org-store-link'.
;; ;;   %i          initial content, copied from the active region.  If %i is
;; ;;               indented, the entire inserted text will be indented as well.
;; ;;   %A          like %a, but prompt for the description part.
;; ;;   %c          current kill ring head.
;; ;;   %x          content of the X clipboard.
;; ;;   %k          title of currently clocked task.
;; ;;   %K          link to currently clocked task.
;; ;;   %n          user name (taken from `user-full-name').
;; ;;   %f          file visited by current buffer when org-capture was called.
;; ;;   %F          full path of the file or directory visited by current buffer.
;; ;;   %:keyword   specific information for certain link types, see below.
;; ;;   %^g         prompt for tags, with completion on tags in target file.
;; ;;   %^G         prompt for tags, with completion on all tags in all agenda files.
;; ;;   %^t         like %t, but prompt for date.  Similarly %^T, %^u, %^U.
;; ;;               You may define a prompt like %^{Please specify birthday.
;; ;;   %^C         interactive selection of which kill or clip to use.
;; ;;   %^L         like %^C, but insert as link.
;; ;;   %^{prop}p   prompt the user for a value for property `prop'.
;; ;;   %^{prompt}  prompt the user for a string and replace this sequence with it.
;; ;;               A default value and a completion table ca be specified like this:
;; ;;               %^{prompt|default|completion2|completion3|...}.
;; ;;   %?          After completing the template, position cursor here.

;; (require 'org-mac-link-grabber)
;; (add-hook 'org-mode-hook
;;           (lambda ()
;;             (define-key org-mode-map (kbd "C-c g") 'omlg-grab-link)))

;; ;; org-clock setting
;; (setq org-clock-persist 't)
;; (org-clock-persistence-insinuate)

;; add contrib for ox-taskjuggler
(add-to-list 'load-path "~/.emacs.d/lisp/org/contrib/lisp")


;; after Emacs 28, default value is changed to showeverything
(setq org-startup-folded t)
