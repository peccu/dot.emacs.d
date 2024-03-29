(when (or
       ;; peccu-p
       win-env-p
       ;; wsl-p
       )
  (require 'org)
  ;; for s-repeat
  (require 's)

  (defun copy-as-markdown-list ()
    (interactive)
    (if (not (org-current-level))
        (message "not in org headings")
      (save-excursion
        (save-restriction
          (let ((star-count (org-current-level)))
            (org-mark-subtree)
            (narrow-to-region (region-beginning) (region-end))
            (let ((buf (current-buffer))
                  (from (point-min))
                  (to (point-max)))
              (with-temp-buffer
                (switch-to-buffer (current-buffer) nil t)
                (insert-buffer-substring buf from to)
                (goto-char (point-min))
                (while (re-search-forward "\* " nil t)
                  (replace-match "*- "))
                (goto-char (point-min))
                (while (re-search-forward (concat "^" (s-repeat star-count "\\*")) nil t)
                  (replace-match "")
                  (next-line)
                  (beginning-of-line))
                (goto-char (point-min))
                (while (re-search-forward "\*" nil t)
                  (replace-match "  "))
                (kill-ring-save (point-min) (point-max))
                (message "markdown list has copied"))))
          (deactivate-mark)))))
  )
