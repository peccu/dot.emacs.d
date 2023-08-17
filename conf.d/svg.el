;; ;; https://github.com/rougier/svg-lib
;; (require 'svg-lib)
;; (insert-image (svg-lib-tag "TODO"))
;; (insert-image (svg-lib-progress 0.33))
;; (insert-image (svg-lib-icon "star"))

;; (dotimes (i 5)
;;   (insert-image (svg-lib-tag "TODO" nil
;;                       :font-family "Roboto Mono" :font-weight (* (+ i 2) 100))))



;; (dotimes (i 10)
;;   (insert-image (svg-lib-tag "TODO" nil :padding 1 :stroke (/ i 4.0))))



;; (dotimes (i 10)
;;   (insert-image (svg-lib-tag "TODO" nil :stroke 2 :radius i)))



;; (dotimes (i 10)
;;   (insert-image (svg-lib-progress (/ (+ i 1) 10.0) nil
;;                     :width 5 :margin 1 :stroke 2 :padding 2)))



;; (insert-image (svg-lib-progress 0.75 nil :radius 8 :stroke 2 :padding 0))



;; (dotimes (i 10)
;;   (insert-image (svg-lib-icon "star" nil :scale (/ (+ i 1) 10.0))))



;; (insert-image (svg-lib-button "check-bold" "DONE" nil
;;                               :font-family "Roboto Mono"
;;                               :font-weight 500
;;                          :stroke 0 :background "#673AB7" :foreground "white"))


;; (insert-image (svg-lib-icon "gnuemacs" nil :collection "simple"
;;                             :stroke 0 :scale 1 :padding 0))

;; (require 'svg-lib)

;; (defvar svg-font-lock-keywords
;;   `(("TODO"
;;      (0 (list 'face nil 'display (svg-font-lock-todo))))
;;     ("\\:\\([0-9a-zA-Z]+\\)\\:"
;;      (0 (list 'face nil 'display (svg-font-lock-tag (match-string 1)))))
;;     ("DONE"
;;      (0 (list 'face nil 'display (svg-font-lock-done))))
;;     ("\\[\\([0-9]\\{1,3\\}\\)%\\]"
;;      (0 (list 'face nil 'display (svg-font-lock-progress_percent (match-string 1)))))
;;     ("\\[\\([0-9]+/[0-9]+\\)\\]"
;;      (0 (list 'face nil 'display (svg-font-lock-progress_count (match-string 1)))))))

;; (defun svg-font-lock-tag (label)
;;   (svg-lib-tag label nil :margin 0))

;; (defun svg-font-lock-todo ()
;;   (svg-lib-tag "TODO" nil :margin 0
;;                :font-family "Roboto Mono" :font-weight 500
;;                :foreground "#FFFFFF" :background "#673AB7"))

;; (defun svg-font-lock-done ()
;;   (svg-lib-tag "DONE" nil :margin 0
;;                :font-family "Roboto Mono" :font-weight 400
;;                :foreground "#B0BEC5" :background "white"))

;; (defun svg-font-lock-progress_percent (value)
;;   (svg-image (svg-lib-concat
;;               (svg-lib-progress (/ (string-to-number value) 100.0)
;;                                 nil :margin 0 :stroke 2 :radius 3 :padding 2 :width 12)
;;               (svg-lib-tag (concat value "%")
;;                            nil :stroke 0 :margin 0)) :ascent 'center))

;; (defun svg-font-lock-progress_count (value)
;;   (let* ((seq (mapcar #'string-to-number (split-string value "/")))
;;          (count (float (car seq)))
;;          (total (float (cadr seq))))
;;   (svg-image (svg-lib-concat
;;               (svg-lib-progress (/ count total) nil
;;                                 :margin 0 :stroke 2 :radius 3 :padding 2 :width 12)
;;               (svg-lib-tag value nil
;;                            :stroke 0 :margin 0)) :ascent 'center)))

;; ;; Activate
;; (push 'display font-lock-extra-managed-props)
;; (font-lock-add-keywords nil svg-font-lock-keywords)
;; (font-lock-flush (point-min) (point-max))

;; ;; Deactivate
;; ;; (font-lock-remove-keywords nil svg-font-lock-keywords)
;; ;; (font-lock-flush (point-min) (point-max))
