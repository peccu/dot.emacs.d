;; (load "~/.emacs.d/conf.d/emacs-path.el")
;; ;; anything-howmがanything-migemoをrequireしているので
;; (load "~/.emacs.d/conf.d/migemo.el")
;; (load "~/.emacs.d/conf.d/anything-howm.el")

;; stop warning
;; https://myhobby20xx.hatenadiary.org/entry/20110308/1299593824
(defvar org-directory "")

(require 'anything)
(require 'anything-config)
(require 'anything-gtags)
(require 'anything-delicious)
(require 'anything-ipa)
(require 'anything-match-plugin)
(require 'anything-c-lisp-complete-symbol)
(require 'anything-c-aspell-interactively)
(require 'anything-c-source-other-windows)
(require 'anything-c-source-shell-command)
(require 'anything-bm-global)
(require 'recentf)
(require 'anything-find-file)
;; cf.http://twitter.com/tomoyaton/status/14764262507
;; タイプしてからリフレッシュするまでの時間
(setq anything-input-idle-delay 0.2)
;; 自動でリフレッシュするまでの時間
(setq anything-idle-delay 0)
;; https://twitter.com/rubikitch/status/245101127085993984
(setq anything-mode-line-string nil)
;; (setq anything-quick-update t)
;; (anything-iswitchb-setup)
;; anything-find-file-as-rootでsuじゃなくsudoするように
(setq anything-su-or-sudo "sudo")
(setq anything-sources (list
                        ;; anything-c-source-ffap-guesser
                        ;; anything-c-source-ffap-line
                        ;; anything-c-source-buffers+-howm-title
                        ;;
                        ;; in buffer
                        ;; anything-c-source-bm
                        ;; anything-c-source-bookmarks
                        ;; anything-c-source-occur ; 行数に比例->直接実行すること
                        ;; anything-c-source-gtags-select
                        ;; anything-c-source-eev-anchor
                        ;; anything-c-source-imenu ; バッファごとで初回起動時遅い
                        ;;
                        ;; other frame,screen
                        anything-c-source-other-windows
                        ;; anything-c-source-elscreen
                        ;;
                        ;; other file(not open)
                        ;; anything-c-source-ipa-global ; 直接必要は無いと判断
                        ;; anything-c-source-bm-global ; 同上
                        nym:anything-find-file
                        anything-c-source-recentf
                        anything-c-source-file-name-history
                        anything-c-source-files-in-current-dir
                        ;; anything-c-source-home-directory
                        anything-c-source-locate
                        ;;
                        ;; execution
                        ;; anything-c-source-shell-command
                        ;; anything-c-source-emacs-commands ; 激しく重い
                        anything-c-source-extended-command-history
                        anything-c-source-complex-command-history
                        ;;
                        ;; slow source
                        ;; anything-c-source-mac-spotlight
                        ;; anything-c-source-evaluation-result ; 使い道...
                        ;; anything-c-source-calculation-result
                        ;; anything-c-source-google-suggest
                        ;; anything-c-source-delicious
                        ;; anything-c-source-aspell-interactively ; input補助
                        ;;
                        ;; documents
                        ;; anything-c-source-info-pages ; なんかうまくいかない
                        ;; anything-c-source-man-pages ; 激しく遅い
                        ;;
                        ;; others
                        ;; anything-c-source-colors
                        )
      )
;; http://d.hatena.ne.jp/buzztaiki/20110123/1295803560
(require 'anything-match-plugin)
(require 'amp-glob)
(amp-glob-mode 1)

;; (setq anything-type-actions (list anything-actions-buffer
;;                                   anything-actions-file
;;                                   anything-actions-sexp))
;; アルファベットのショートカット
;; (setq anything-enable-shortcuts 'alphabet)
(defadvice anything-check-minibuffer-input (around sit-for activate)
  (if (sit-for anything-idle-delay t)
      ad-do-it))
;; シンボル補完
(global-set-key "\M-_" 'anything-lisp-complete-symbol)
;; anything-resumeはhelm.elの resume-helm-or-anythingに移動
;; (define-key global-map (kbd "C-.") 'anything-resume)
;; (define-key global-map (kbd "C-M-:") 'anything-call-source)
;; (define-key global-map [(control ?:)] 'anything)
;; (when lab-imac-p                        ;US配列キーボード
(define-key global-map [(control ?')] 'anything)
(define-key global-map [(control meta ?')] 'anything-call-source)
;; )

;; anything-complete
(require 'anything-complete)
(require 'anything-show-completion)
;; C-xdでもanythingになって，大変
(anything-read-string-mode 1)

;; ;; http://d.hatena.ne.jp/k6ky/20111227/1324987106
;; (require 'anything-bibtex)

;; デフォルトの動作になった
;; http://twitter.com/peccul/status/8800890044
;; ->http://twitter.com/rubikitch/status/8801769013
;; anythingから抜ける時にカレントフレーム以外を再描画するのを止める
;; (setq anything-save-configuration-functions '(set-window-configuration . current-window-configuration))

;; http://twitter.com/rubikitch/status/9661285306
;; (insert (format "\n;;  => %s" (benchmark-run (anything-test-candidates 'anything-c-source-buffers "m"))))
;; (insert (format "\n;;  => %s" (benchmark-run (anything-test-candidates 'anything-c-source-ffap-guesser "m"))))
;; (insert (format "\n;;  => %s" (benchmark-run (anything-test-candidates 'anything-c-source-ffap-line "m"))))
;; (insert (format "\n;;  => %s" (benchmark-run (anything-test-candidates 'anything-c-source-buffers+ "m"))))
;; (insert (format "\n;;  => %s" (benchmark-run (anything-test-candidates 'anything-c-source-bm "m"))))
;; (insert (format "\n;;  => %s" (benchmark-run (anything-test-candidates 'anything-c-source-bookmarks "m"))))
;; (insert (format "\n;;  => %s" (benchmark-run (anything-test-candidates 'anything-c-source-occur "m"))))
;; (insert (format "\n;;  => %s" (benchmark-run (anything-test-candidates 'anything-c-source-gtags-select "m"))))
;; (insert (format "\n;;  => %s" (benchmark-run (anything-test-candidates 'anything-c-source-eev-anchor "m"))));!!  => (0.002401 0 0.0)
;; (insert (format "\n;;  => %s" (benchmark-run (anything-test-candidates 'anything-c-source-other-windows "m"))))
;; (insert (format "\n;;  => %s" (benchmark-run (anything-test-candidates 'anything-c-source-ipa-global "m"))))
;; (insert (format "\n;;  => %s" (benchmark-run (anything-test-candidates 'anything-c-source-bm-global "m"))))
;; (insert (format "\n;;  => %s" (benchmark-run (anything-test-candidates 'anything-c-source-recentf "m"))))
;; (insert (format "\n;;  => %s" (benchmark-run (anything-test-candidates 'anything-c-source-file-name-history "m"))))
;; (insert (format "\n;;  => %s" (benchmark-run (anything-test-candidates 'anything-c-source-files-in-current-dir "m"))))
;; (insert (format "\n;;  => %s" (benchmark-run (anything-test-candidates 'anything-c-source-home-directory "m"))))
;; (insert (format "\n;;  => %s" (benchmark-run (anything-test-candidates 'anything-c-source-shell-command "m"))))
;; (insert (format "\n;;  => %s" (benchmark-run (anything-test-candidates 'anything-c-source-emacs-commands "m"))))
;; (insert (format "\n;;  => %s" (benchmark-run (anything-test-candidates 'anything-c-source-extended-command-history "m"))))
;; (insert (format "\n;;  => %s" (benchmark-run (anything-test-candidates 'anything-c-source-complex-command-history "m"))))
;; (insert (format "\n;;  => %s" (benchmark-run (anything-test-candidates 'anything-c-source-imenu "m"))))
;; (insert (format "\n;;  => %s" (benchmark-run (anything-test-candidates 'anything-c-source-mac-spotlight "m"))))
;; (insert (format "\n;;  => %s" (benchmark-run (anything-test-candidates 'anything-c-source-evaluation-result "m"))))
;; (insert (format "\n;;  => %s" (benchmark-run (anything-test-candidates ';; anything-c-source-calculation-result "m"))))
;; (insert (format "\n;;  => %s" (benchmark-run (anything-test-candidates ';; anything-c-source-google-suggest "m"))))
;; (insert (format "\n;;  => %s" (benchmark-run (anything-test-candidates 'anything-c-source-delicious "m"))))
;; (insert (format "\n;;  => %s" (benchmark-run (anything-test-candidates ';; anything-c-source-aspell-interactively "m"))))
;; (insert (format "\n;;  => %s" (benchmark-run (anything-test-candidates ';; documents "m"))))
;; (insert (format "\n;;  => %s" (benchmark-run (anything-test-candidates ';; anything-c-source-info-pages "m"))))
;; (insert (format "\n;;  => %s" (benchmark-run (anything-test-candidates ';; anything-c-source-man-pages "m"))))
;; (insert (format "\n;;  => %s" (benchmark-run (anything-test-candidates ';; others "m"))))
;; (insert (format "\n;;  => %s" (benchmark-run (anything-test-candidates 'anything-c-source-colors "m"))))

(define-key global-map (kbd "M-y") 'anything-show-kill-ring)

;; describe-bindingsのラッパ
;; http://d.hatena.ne.jp/buzztaiki/20081115/1226760184
(require 'descbinds-anything)
(descbinds-anything-install)
