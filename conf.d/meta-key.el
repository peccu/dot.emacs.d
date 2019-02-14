;; Cocoa EmacsでメタキーをCommandキーにする
(when darwin-p
  (setq ns-command-modifier 'meta)
  (setq ns-alternate-modifier 'super))
