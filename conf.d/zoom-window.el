(require 'zoom-window)
;; overwrite windows.el
(eval-after-load 'windows
  (define-key win:switch-map (kbd "SPC") 'zoom-window-zoom))
