;; (add-to-list 'load-path "~/.emacs.d/lisp/eev-current")
(unless (package-installed-p 'eev)
  (package-install 'eev))

;; my setting for eev-mode-map
(setq eev-mode-map (make-sparse-keymap))
(define-key eev-mode-map "\M-e" 'eek-eval-sexp-eol) ; extends C-e C-x C-e
(define-key eev-mode-map "\M-E" 'eek-eval-last-sexp) ; extends    C-x C-e
(define-key eev-mode-map "\M-k" 'kill-this-buffer)
(define-key eev-mode-map "\M-K" 'bury-buffer)
(define-key eev-mode-map [f3]   'eeb-default)
;; (define-key eev-mode-map [f8]   'eepitch-this-line)
;; (define-key eev-mode-map [f9]   'eechannel-do-this-line)
;; (define-key eev-mode-map [f12]  'eesteps-do-step)
;; (define-key eev-mode-map "\M-P" 'ee-yank-one-line)
;; For "compose pairs":
(define-key eev-mode-map [?\M-,] 'eev-compose-two-keys) ; works anywhere
(define-key eev-mode-map "\M-h\M-d" 'find-debpkg-links)    
(define-key eev-mode-map "\M-h\M-e" 'find-eev-mode-links) ; special
(define-key eev-mode-map "\M-h\M-f" 'find-efunction-links) 
(define-key eev-mode-map "\M-h\M-i" 'find-einfo-links)     
(define-key eev-mode-map "\M-h\M-k" 'find-ekey-links)      
(define-key eev-mode-map "\M-h\M-m" 'find-manpage-links)   
(define-key eev-mode-map "\M-h\M-v" 'find-evariable-links) 
(define-key eev-mode-map "\M-hf"    'find-file-links)      
(define-key eev-mode-map "\M-hm"    'find-last-manpage-links)
(define-key eev-mode-map "\M-h\M-s" 'find-efacedescr)
(define-key eev-mode-map "\M-h\M-c" 'describe-char)
(define-key eev-mode-map "\M-h\M-t" 'find-etpat)
(define-key eev-mode-map "\M-ht"    'find-etpat0)
(define-key eev-mode-map "\M-h\M-y" 'eemklinks-yank-pos-spec)
(define-key eev-mode-map "\M-h\M-2" 'eemklinks-duplicate-this-line)
(define-key eev-mode-map "\M-h2"    'eemklinks-duplicate-this-line)
(define-key eev-mode-map "\C-z\C-d" 'eemklinks-duplicate-this-line)
(define-key eev-mode-map "\M-F" 'ee-wrap-file)
(define-key eev-mode-map "\M-M" 'ee-wrap-man)
(define-key eev-mode-map "\M-S" 'ee-wrap-sh)
;; (define-key eev-mode-map "\M-C" 'ee-wrap-code-c-d)
(define-key eev-mode-map "\M-D" 'ee-wrap-debian)
(define-key eev-mode-map "\M-T" 'ee-wrap-eepitch)
(define-key eev-mode-map "\M-?" 'eev-help-page)
;; (define-key eev-mode-map "\M-I" 'ee-ill)


(require 'eev-load)
(eev-mode 1)

;; http://rakunet.org/TSNET/TSfree/12/371.html
(defun ee-next-sexp ()
  (interactive)
  (re-search-forward ")$"))
(defun ee-prev-sexp ()
  (interactive)
  (re-search-backward ")$"))
(global-set-key "\M-p" 'ee-prev-sexp)
(global-set-key "\M-n" 'ee-next-sexp)


;; (eeindex)
;; <<<INDEX>>>
;; (to "keymaps")
;; <<<keymaps>>>
;; Local Variables:
;; ee-anchor-format: "<<<%s>>>"
;; End:
