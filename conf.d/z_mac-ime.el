(when (or
       peccu-p
       ;; win-env-p
       ;; wsl-p
       )
  (when
      ;; not peccu-p
      carbon-p
    ;; Emacs Mac Portsの場合、IME拡張を有効にする
    (mac-auto-ascii-mode 1)
    ;; インラインパッチ適応されているかどうか
    (defvar is_inline-patch (eq (boundp 'mac-input-method-parameters) t))
    ;; インラインパッチ適応の場合は次の設定にする(例)
    (when is_inline-patch
      (setq default-input-method "MacOSX")
      (mac-set-input-method-parameter
       "com.apple.keylayout.US" 'cursor-type 'bar)
      (mac-set-input-method-parameter
       "com.apple.inputmethod.Kotoeri.Japanese" 'cursor-type '(hbar . 3))
      (mac-set-input-method-parameter
       "com.apple.inputmethod.Kotoeri.Japanese" 'cursor-color "red")
      )
    (defun mac-selected-keyboard-input-source-change-hook-func ()
      ;; 入力モードが英語の時はカーソルの色をfirebrickに、日本語の時はblackにする
      (set-cursor-color (if (string-match "\\.US$" (mac-input-source))
                            "firebrick" "black")))
    (add-hook 'mac-selected-keyboard-input-source-change-hook
              'mac-selected-keyboard-input-source-change-hook-func)

    (defun mac-selected-keyboard-input-source-change-hook-func ()
      ;; 入力モードが英語の時はカーソルの色をfirebrickに、日本語の時はblackにする
      ;; http://masutaka.net/chalow/2015-01-04-1.html
      (set-cursor-color (if (string-match "\\.US$" (mac-input-source))
                            "firebrick" "green")))
    (add-hook 'mac-selected-keyboard-input-source-change-hook
              'mac-selected-keyboard-input-source-change-hook-func)
    )
  )
