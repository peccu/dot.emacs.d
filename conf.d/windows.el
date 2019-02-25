;; ;; windows.el
;; ;; http://d.hatena.ne.jp/gan2/20080726/1217056464
;; ;;; windows.el
;; ;; 分割されたウィンドウを切り替えることができる。
;; ;; さらに、分割形態を保存することもできる。
;; ;;
;; ;; キーバインド C-z にを変更。デフォルトは C-c C-w。
;; ;; 変更しない場合は，以下の 3 行を削除する。
;; ;; C-z n   前のウィンドウ
;; ;; C-z p   後のウィンドウ
;; ;; C-z !   現在のウィンドウを破棄
;; ;; C-z C-m メニューの表示
;; ;; C-z ;   ウィンドウの一覧を表示
;; (setq win:switch-prefix "\C-z")
;; (define-key global-map win:switch-prefix nil)
;; ;; (define-key global-map "\C-z1" 'win-switch-to-window)
;; ;; 1-9 ではなく a-z でウィンドウを管理する
;; (setq win:base-key ?`) ;; ` は「直前の状態」
;; (setq win:max-configs 27) ;; ` ～ z は 27 文字
;; (setq win:quick-selection nil) ;; C-c 英字 に割り当てない
;; (require 'windows)
;; ;; 新規にフレームを作らない
;; (setq win:use-frame nil)
;; (win:startup-with-window)
;; ;; ;; C-x C-c で終了するとそのときのウィンドウの状態を保存する
;; ;; ;; C-x C なら保存しない
;; ;; (define-key ctl-x-map "\C-c" 'see-you-again)
;; ;; (define-key ctl-x-map "C" 'save-buffers-kill-emacs)
;; ;; *migemo* のようなバッファも保存
;; (setq revive:ignore-buffer-pattern "^ \\*")
;; ;; ;; キーバインドの追加
;; ;; (add-hook 'win:add-hook
;; ;;     '(lambda ()
;; ;;        (define-key win: "\C-c\C-g" 'clgrep)
;; ;;        ))
;; ;; (define-key win:switch-map "\C-m" 'win-menu)
;; ;; (define-key win:switch-map ";" 'win-switch-menu)

;; (defun win:select-frame (num)
;;   "Select the NUM-th window frame."
;;   (if (= (length (frame-list)) 1)
;;       (if (eq (selected-frame) (aref win:configs num)) (selected-frame) nil)
;;     (let ((goal (aref win:configs num)))
;;       (if (null (frame-live-p goal))
;; 	  (aset win:configs num nil)	;returns NIL
;; 	;(if (eq (cdr (assq 'visibility (frame-parameters goal))) 'icon)
;; 	;    (make-frame-visible goal))	;to de-iconify(if iconified)
;; 	;;'visibility attribute is not defined in XEmacs...
;; 	(or (eq t (frame-visible-p goal))
;; 	    (make-frame-visible goal))
;; 	(while (not (frame-visible-p goal)) (sit-for 0))
;; 	(raise-frame goal)
;; 	(x-focus-frame goal)
;; 	(select-frame goal)
;; 	(if (not (eq (selected-frame) goal))
;; 	    nil
;; 	  (or win:xemacs-p (unfocus-frame))
;; 	  ;; Emacs-21.0.9x sometimes fails to display some part of frame
;; 	  (if (string< "21.0.92" emacs-version)
;; 	      (sit-for (string-to-number "1e-5")))
;; 	  (apply 'set-mouse-pixel-position
;; 		 (if win:xemacs-p (selected-window) goal)
;; 		 win:mouse-position)
;; 	  goal)))))


;; ;; 新規フレームの位置を手動で設定する
;; (setq win:auto-position nil)

;; ;; ;; *migemo* のようなバッファも保存
;; ;; (setq revive:ignore-buffer-pattern "^ \\*")
;; (require 'anything-c-source-other-windows)

(setq win:switch-prefix "\C-z")
(define-key global-map win:switch-prefix nil)
;; ` は「直前の状態」
(setq win:base-key ?`)
;; ` ～ z は27文字
(setq win:max-configs 27)
;; C-c英字 に割り当てない
(setq win:quick-selection nil)
(require 'windows)
;; prefix nとprefix pがwin-(next|prev)-windowに上書きされるので再設定
(let ((key win:base-key) (max (+ win:base-key win:max-configs)))
    (while (< key max)
      (define-key win:switch-map (char-to-string key) 'win-switch-to-window)
      (setq key (1+ key))))

;; フレームを使わない(気分はElscreen)
(setq win:use-frame nil)
(win:startup-with-window)
;; C-xCでwindow状態を保存してemacsを終了する
(define-key ctl-x-map "C" 'see-you-again)
(define-key win:switch-map "\C-z" 'win-toggle-window)
;; ;; active in zoom-window.el
;; (define-key win:switch-map (kbd "SPC") 'zoom-window-zoom)
(define-key win:switch-map "=" 'anything-other-windows)

;; 自動でwin-all-save-configurationsを呼び出す
(setq auto-win-save-all-conf-timer 120)
(require 'auto-win-save-all-configurations)

;; revive.elで保存する変数
(setq revive:save-variables-global-default
      '(truncate-partial-width-windows
        make-backup-files
        version-control
        visible-bell
        file-name-history
        buffer-name-history
        minibuffer-history
        shell-command-history))

;; 設定ファイルの保存先
(setq win:configuration-file (concat user-emacs-directory ".windows"))
