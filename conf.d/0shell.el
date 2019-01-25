(require 'shell)
;; (setq explicit-shell-file-name "bash.exe")
;; (setq shell-command-switch "-c")
;; (setq shell-file-name "bash.exe")

;; (M-! and M-| and compile.el)
;; (setq shell-file-name "C:/Apps/gnupack_devel-11.00/app/cygwin/cygwin/bin/bash.exe")
;; org.elにも記述してる
;; (modify-coding-system-alist 'process ".*sh\\.exe" 'cp932)
;; (setenv "SHELL" shell-file-name)
(setenv "LANG" "ja_JP.UTF-8")
;; for edbi and cpanm
(setenv "PERL5LIB" "/Users/shimatani/perl5/lib/perl5")
;; for magit? mew?
;; (setq system-type 'windows-nt)
;; (setq system-type 'cygwin)

;; shellモードの時の^M抑制
(add-hook 'comint-output-filter-functions 'shell-strip-ctrl-m nil t)

;; shell-modeでの補完 (for drive letter)
;; (setq shell-file-name-chars "~/A-Za-z0-9_^$!#%&{}@'`.,;()-")

;; エスケープシーケンス処理の設定
(autoload 'ansi-color-for-comint-mode-on "ansi-color"
  "Set `ansi-color-for-comint-mode' to t." t)

;; (setq shell-mode-hook
;;       (function
;;        (lambda ()
;;          ;; シェルモードの入出力文字コード
;;          (set-buffer-process-coding-system 'sjis-dos 'sjis-unix)
;;          (set-buffer-file-coding-system    'sjis-unix)
;;          )))
