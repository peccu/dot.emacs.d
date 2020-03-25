;; (define-key global-map [f5]
;;   '(lambda ()
(defvar insert-date-format-history nil)
(defun insert-date (arg)
  "Insert date with specific format.

Default format is %Y/%m/%d.
Call with `C-u' inserts %Y%m%d.
with `C-u C-u' inserts %Y-%m-%d.
with `C-u C-u C-u' prompts format."
  (interactive "p")
  (let* ((default-format "%Y/%m/%d %H:%M:%S")
         (fmt (case arg
                (64 (read-string
                     (format "Format (default %s): " default-format)
                     ""
                     'insert-date-format-history
                     default-format))
                (16 "%Y-%m-%d")
                (4 "%Y%m%d")
                (t "%Y/%m/%d")
                )))
    (insert (format-time-string fmt))))

(global-set-key (kbd "C-c d") 'insert-date)

(defun insert-date-time ()
  (interactive)
  (insert (format-time-string "%Y/%m/%d %H:%M:%S")))

;; set locale for date format
(setq system-time-locale "C")

(global-set-key (kbd "C-c C-t") 'insert-date-time)

(defun insert-date-by-format ()
  (interactive)
  (let* ((default-format "%Y/%m/%d %H:%M:%S")
         (fmt (read-from-minibuffer
               (format "Format (default %s): " default-format)
               default-format)))
    (insert (format-time-string fmt))))

;; ;; http://d.hatena.ne.jp/myhobby20xx/20110316/1300290575
;; (let (;; timeに現在時刻をデコードしてセット
;;       (time (decode-time (current-time)))
;;       ;; 曜日番号(月=1,...)を使って次の月曜日までの日数を求める
;;       (days-to-monday (+ 8 (- (string-to-number (format-time-string "%u" (current-time)))) ))
;;       )
;;   ;; 日付を進める
;;   (setf (elt time 3) (+ (elt time 3) days-to-monday))
;;   ;; フォーマットする
;;   (format-time-string "%Y/%m/%d" (apply 'encode-time time))
;;   )

(defun increment-day (days)
  (let (;; timeに現在時刻をデコードしてセット
        (time (decode-time (current-time))))
    ;; 日付を進める
    (setf (elt time 3) (+ (elt time 3) days))
    ;; 時刻形式にする
    (apply 'encode-time time)
    ))

(defun next-monday ()
  (interactive)
  (let (;; 曜日番号(月=1,...)を使って次の月曜日までの日数を求める
        (days-to-monday (+ 8 (- (string-to-number (format-time-string "%u" (current-time)))) ))
        )
    (format-time-string "%Y/%m/%d" (increment-day days-to-monday))))

(defun insert-next-monday ()
  (interactive)
  (insert (next-monday)))
