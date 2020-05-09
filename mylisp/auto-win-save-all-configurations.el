;; Idleを見計らって自動的にwin-save-all-configurationsを呼び出す設定
(require 'windows)

(defvar auto-win-save-all-conf-timer 30
  "何秒Idleになれば`win-save-all-configurations'を呼び出すか．")

(defvar already-win-load-all-configurations nil
  "`win-load-all-configurations'が呼び出されたらtになる．
多重にタイマーが動くのを防ぐため．")

(defvar win-auto-saved-time nil
  "自動で保存された時刻")

(defvar win-auto-saved-time-delay 5
  "この時間以上経過後に操作があれば(アイドルタイマーがリセットされれば)`win-save-all-configurations'を呼び出す．")

(defun auto-win-save-all-configurations ()
  "save all windows configurations when previous saved time is in `auto-win-save-all-conf-timer'."
  (let* ((current-time (current-time))
         (high (car current-time))
         (low (cadr current-time))
         (time (+ (* high 65536) low))) ;2^16
    (when (> (- time win-auto-saved-time win-auto-saved-time-delay) ;前回保存した時刻から30-5秒以上経過してたら保存する
             auto-win-save-all-conf-timer)                          ;前回保存後5秒以上立ってから操作があれば保存するし，操作が無ければ保存しない
          (setq win-auto-saved-time time)
          (let ((print-length nil)
                (eval-expression-print-length nil)
                (print-level nil)
                (eval-expression-print-level nil))
            (win-save-all-configurations)))))
;; (auto-win-save-all-configurations)

;; prefix C-r rで呼び出すResume-allにタイマー実行をアドバイスする
(defadvice win-load-all-configurations (after win-load-all-configurations-after-advice (&optional preserve))
  (unless already-win-load-all-configurations
    ;; (run-with-idle-timer auto-win-save-all-conf-timer t 'win-save-all-configurations)
    (let* ((current-time (current-time))
           (high (car current-time))
           (low (cadr current-time))
           (time (+ (* high 65536) low))) ;2^16
      (setq win-auto-saved-time time))
    (run-with-idle-timer auto-win-save-all-conf-timer t 'auto-win-save-all-configurations)
    (setq already-win-load-all-configurations t)))
(ad-activate 'win-load-all-configurations)
;; (ad-deactivate 'win-load-all-configurations)

(provide 'auto-win-save-all-configurations)
