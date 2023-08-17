(when (or
       peccu-p
       win-env-p
       wsl-p
       )
  ;; http://ergoemacs.org/emacs/emacs_encoding_decoding_faq.html
  (set-language-environment "UTF-8")
  (setq-default buffer-file-coding-system 'utf-8-unix)
  )
