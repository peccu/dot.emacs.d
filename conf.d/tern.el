(add-to-list 'load-path (concat user-emacs-directory "git/tern/emacs/"))
(require 'tern)
;; (add-hook 'js2-mode-hook (lambda () (tern-mode t)))
;; (add-hook 'js-mode-hook (lambda () (tern-mode t)))
;; (eval-after-load 'tern
;;    '(progn
;;       (require 'tern-auto-complete)
;;       (tern-ac-setup)))

;; http://aki2o.hatenablog.jp/entry/2014/08/14/EmacsでTernのサードパーティ製プラグインを使おうとし
(add-to-list 'exec-path-from-shell-variables "NODE_PATH")
;; ;; add below to ~/.tern-config
;; {
;;   "libs": [
;;     "browser",
;;     "jquery",
;;     "ecma5",
;;     "underscore"
;;   ],
;;   "plugins": {
;;     "angular": {},
;;     "node": {}
;;   }
;; }

;; to company.el
;; (require 'company-tern)
;; (add-to-list 'company-backends 'company-tern)
