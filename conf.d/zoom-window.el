(require 'zoom-window)
;; overwrite windows.el
(define-key win:switch-map (kbd "SPC") 'zoom-window-zoom)
