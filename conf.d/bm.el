(when (or
       peccu-p
       win-env-p
       ;; wsl-p
       )
  (require-with-install 'bm)
  ;; http://emacs.rubikitch.com/helm-bm/
  (defun bm-toggle-or-helm ()
    "2回連続で起動したらhelm-bmを実行させる"
    (interactive)
    (bm-toggle)
    (when (eq last-command 'bm-toggle-or-helm)
      (helm-bm)))

  (global-set-key (kbd "<M-f2>") 'bm-toggle-or-helm)
  (global-set-key (kbd "<M-f3>") 'bm-previous)
  (global-set-key (kbd "<M-f4>") 'bm-next)
  ;; save bookmarks
  (setq-default bm-buffer-persistence t)
  ;; Filename to store persistent bookmarks
  (setq bm-repository-file (concat user-emacs-directory ".bm-repository"))

  ;; Loading the repository from file when on start up.
  (add-hook' after-init-hook 'bm-repository-load)

  ;; Restoring bookmarks when on file find.
  (add-hook 'find-file-hooks 'bm-buffer-restore)

  ;; Saving bookmark data on killing and saving a buffer
  (add-hook 'kill-buffer-hook 'bm-buffer-save)
  (add-hook 'auto-save-hook 'bm-buffer-save)
  (add-hook 'after-save-hook 'bm-buffer-save)

  ;; Saving the repository to file when on exit.
  ;; kill-buffer-hook is not called when emacs is killed, so we
  ;; must save all bookmarks first.
  (add-hook 'kill-emacs-hook '(lambda nil
                                (bm-buffer-save-all)
                                (bm-repository-save)))


  (when (or
         peccu-p
         ;; win-env-p
         ;; wsl-p
         )
    ;;   Click on fringe to toggle bookmarks, and use mouse wheel to move
    ;;   between them.
    (global-set-key (kbd "<left-fringe> <mouse-5>") 'bm-next-mouse)
    (global-set-key (kbd "<left-fringe> <mouse-4>") 'bm-previous-mouse)
    (global-set-key (kbd "<left-fringe> <mouse-1>") 'bm-toggle-mouse)
    )
  ;;
  ;;   If you would like the markers on the right fringe instead of the
  ;;   left, use bm-fringe-markers-on-right.
  ;;
  (setq bm-marker 'bm-marker-right)

  (when (or
         ;; peccu-p
         win-env-p
         ;; wsl-p
         )
    (defvar auto-bm-save-idle-time 30
      "何秒Idleになれば`bm-save'を呼び出すか．")
    (defun bm-save ()
      (interactive)
      (bm-buffer-save-all)
      (bm-repository-save))
    (run-with-idle-timer auto-bm-save-idle-time t 'bm-save)
    )
  )
