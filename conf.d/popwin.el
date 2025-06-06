(when (or
       peccu-p
       win-env-p
       ;; wsl-p
       )
  (require-with-install 'popwin)
  ;; (setq display-buffer-function 'popwin:display-buffer)
  ;; obsolete from 24.3
  ;; change to this (https://github.com/m2ym/popwin-el/commit/b6ac46b65acb15894ae9ae34686945369d798e93)

  ;; fix some issue
  ;; https://github.com/emacsorphanage/popwin/issues/147
  (defun popwin:window-config-tree-1 (node)
    "Not documented (NODE)."
    (if (windowp node)
        (list 'window
              node
              (window-buffer node)
              (popwin:window-point node)
              (window-start node)
              (window-edges node)
              (eq (selected-window) node)
              (window-dedicated-p node))
      (cl-destructuring-bind (dir edges . windows) node
        (append (list dir edges)
                (cl-loop for window in windows
                         ;; revert the commit https://github.com/emacsorphanage/popwin/commit/c5c98318fa9ceba6f9b1e4c57c5ac0514f057176
                         ;; unless (or (and (windowp window)
                         ;;                 (window-parameter window 'window-side))
                         ;;            (not (windowp window)))
                         unless (and (windowp window)
                                     (window-parameter window 'window-side))
                         collect (popwin:window-config-tree-1 window))))))

  (popwin-mode 1)

  (push '("*grep*" :height 80) popwin:special-display-config)
  (push '("*helm M-x*" :height 30) popwin:special-display-config)
  (push '("*helm kill ring*" :height 30) popwin:special-display-config)
  (push '("*Codic Result*" :height 30) popwin:special-display-config)
  (push '("*Help*" :height 30) popwin:special-display-config)
  (push '("*Flutter*" :height 30 :stick t) popwin:special-display-config)
  ;; (push '("*quickrun*" :height 30) popwin:special-display-config)

  (push '("^\\*ag.*\\*" :regexp t :height 80) popwin:special-display-config)
  (push '("^\\*anything.*\\*$" :regexp t :height 30) popwin:special-display-config)
  (push '("^\\*helm.*\\*$" :regexp t :height 30) popwin:special-display-config)


  ;; (setq popwin:special-display-config
  ;;       '(
  ;;         ("*Miniedit Help*" :noselect t)
  ;;         help-mode
  ;;         (completion-list-mode :noselect t)
  ;;         (compilation-mode :noselect t)
  ;;         (grep-mode :noselect t)
  ;;         (occur-mode :noselect t)
  ;;         ("*Pp Macroexpand Output*" :noselect t)
  ;;         "*Shell Command Output*" "*vc-diff*" "*vc-change-log*" (" *undo-tree*" :width 60 :position right)
  ;;         ("^\\*anything.*\\*$" :regexp t)
  ;;         "*slime-apropos*"
  ;;         "*slime-macroexpansion*"
  ;;         "*slime-description*"
  ;;         ("*slime-compilation*" :noselect t)
  ;;         "*slime-xref*"
  ;;         (sldb-mode :stick t)
  ;;         slime-repl-mode
  ;;         slime-connection-list-mode
  ;;         )
  ;;       )
  )
