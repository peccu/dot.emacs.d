(require 'popwin)
;; (setq display-buffer-function 'popwin:display-buffer)
;; obsolete from 24.3
;; change to this (https://github.com/m2ym/popwin-el/commit/b6ac46b65acb15894ae9ae34686945369d798e93)
(popwin-mode 1)

(push '("\\*grep\\*" :height 80) popwin:special-display-config)
(push '("\\*ag.*\\*" :height 80) popwin:special-display-config)
(push '("^\\*anything.*\\*$" :regexp t :height 30) popwin:special-display-config)
(push '("\\*helm M-x\\*" :height 30) popwin:special-display-config)
(push '("^\\*helm.*\\*$" :regexp t :height 30) popwin:special-display-config)
(push '("^\\*Codic Result\\*$" :regexp t :height 30) popwin:special-display-config)
(push '("^\\*Help\\*$" :regexp t :height 30) popwin:special-display-config)
