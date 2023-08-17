(when (or
       ;; peccu-p
       win-env-p
       ;; wsl-p
       )
  ;; http://d.hatena.ne.jp/sonota88/20110224/1298557375
  ;; http://murakan.cocolog-nifty.com/blog/2011/06/emacs-e05e.html
  ;; 選択範囲の情報表示
  (defun count-lines-and-chars ()
    (if mark-active
        (format "L%d C%d "
                ;; (format "%d lines,%d chars "
                (count-lines (region-beginning) (region-end))
                (- (region-end) (region-beginning)))
      ""))
  ;; (add-to-list 'default-mode-line-format
  ;;              '(:eval (count-lines-and-chars)))

  ;; mode-line.elでmode-lineに登録している
  )
