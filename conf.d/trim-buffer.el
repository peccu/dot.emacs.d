;; cf.http://www.chibutsu.org/faf/WebWiki/emacs/kwatch-mule.html#sec49
;; 余分な空白を削除する
(defun trim-buffer ()
  "Delete excess white space."
  (interactive)
  (save-excursion
    ;; 行末の空白を削除する
    (goto-char (point-min))
    (while (re-search-forward "[ \t]+$" nil t)
      (replace-match "" nil nil))
    ;; ファイルの終わりにある空白行を削除する
    (goto-char (point-max))
    (delete-blank-lines)
    ;; タブを空白に変換する
    (mark-whole-buffer)
    (untabify (region-beginning) (region-end))
    ))

;; ファイルをセーブしたときに自動的に実行させる
;; (add-hook 'write-file-hooks
;;           '(lambda ()
;;              (trim-buffer)))
