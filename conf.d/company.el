(require 'company)
;; https://qiita.com/kod314/items/3a31719db27a166d2ec1
(setq company-minimum-prefix-length 2)
(setq company-selection-wrap-around t)
(setq completion-ignore-case t)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "<tab>") 'company-complete-selection)
;; for search
(define-key company-active-map (kbd "C-s") 'company-filter-candidates)
(define-key company-search-map (kbd "C-n") 'company-select-next)
(define-key company-search-map (kbd "C-p") 'company-select-previous)

(set-face-attribute 'company-tooltip nil :foreground "black" :background "lightgray")
(set-face-attribute 'company-tooltip-selection nil :foreground "black" :background "steelblue")
(set-face-attribute 'company-tooltip-search nil :foreground "#002b37" :background "#244f36")
;; (set-face-attribute 'company-tooltip-search-selection nil :foreground "" :background "")
;; (set-face-attribute 'company-tooltip-mouse nil :foreground "" :background "")
(set-face-attribute 'company-tooltip-common nil ;; :foreground ""
                    :background "red")
(set-face-attribute 'company-tooltip-common-selection nil ;; :foreground ""
                    :background "green")
(set-face-attribute 'company-tooltip-annotation nil ;; :foreground ""
                    :background "yellow")
(set-face-attribute 'company-tooltip-common-selection nil ;; :foreground ""
                    :background "pink")
(set-face-attribute 'company-tooltip-annotation nil ;; :foreground ""
                    :background "blue")
(set-face-attribute 'company-tooltip-annotation-selection nil ;; :foreground ""
                    :background "orange")
(set-face-attribute 'company-scrollbar-fg nil ;; :foreground ""
                    :background "darkgreen")
(set-face-attribute 'company-scrollbar-bg nil ;; :foreground ""
                    :background "darkred")
(set-face-attribute 'company-preview nil ;; :foreground ""
                    :background "purple")
(set-face-attribute 'company-preview-common nil ;; :foreground ""
                    :background "skyblue")
(set-face-attribute 'company-preview-search nil ;; :foreground ""
                    :background "white")
(set-face-attribute 'company-echo nil ;; :foreground ""
                    :background "firebrick4")
;; (set-face-attribute 'company-echo-common nil :foreground "" :background "")
;; (set-face-attribute 'company-echo-common nil :foreground "" :background "")


;; (set-face-attribute 'company-tooltip nil
;;                     :foreground "#36c6b0" :background "#244f36")
;; (set-face-attribute 'company-tooltip-common nil
;;                     :foreground "white" :background "#244f36")
;; (set-face-attribute 'company-tooltip-selection nil
;;                     :foreground "#a1ffcd" :background "#007771")
;; (set-face-attribute 'company-tooltip-common-selection nil
;;                     :foreground "white" :background "#007771")
;; (set-face-attribute 'company-scrollbar-fg nil
;;                     :background "#4cd0c1")
;; (set-face-attribute 'company-scrollbar-bg nil
;;                     :background "#002b37")

;; (set-face-attribute 'company-tooltip nil :foreground "black" :background "lightgrey")
;; (set-face-attribute 'company-tooltip-common nil :foreground "black" :background "lightgrey")
;; (set-face-attribute 'company-tooltip-common-selection nil :foreground "white" :background "steelblue")
;; (set-face-attribute 'company-tooltip-selection nil :foreground "black" :background "steelblue")
;; (set-face-attribute 'company-preview-common nil :background nil :foreground "lightgrey" :underline t)
;; (set-face-attribute 'company-scrollbar-fg nil :background "orange")
;; (set-face-attribute 'company-scrollbar-bg nil :background "gray40")



;; (defface company-tooltip
;;   '((default :foreground "black")
;;     (((class color) (min-colors 88) (background light))
;;      (:background "cornsilk"))
;;     (((class color) (min-colors 88) (background dark))
;;      (:background "yellow")))
;;   "Face used for the tooltip.")

;; (defface company-tooltip-selection
;;   '((((class color) (min-colors 88) (background light))
;;      (:background "light blue"))
;;     (((class color) (min-colors 88) (background dark))
;;      (:background "orange1"))
;;     (t (:background "green")))
;;   "Face used for the selection in the tooltip.")

;; (defface company-tooltip-search
;;   '((default :inherit highlight))
;;   "Face used for the search string in the tooltip.")

;; (defface company-tooltip-search-selection
;;   '((default :inherit highlight))
;;   "Face used for the search string inside the selection in the tooltip.")

;; (defface company-tooltip-mouse
;;   '((default :inherit highlight))
;;   "Face used for the tooltip item under the mouse.")

;; (defface company-tooltip-common
;;   '((((background light))
;;      :foreground "darkred")
;;     (((background dark))
;;      :foreground "red"))
;;   "Face used for the common completion in the tooltip.")

;; (defface company-tooltip-common-selection
;;   '((default :inherit company-tooltip-common))
;;   "Face used for the selected common completion in the tooltip.")

;; (defface company-tooltip-annotation
;;   '((((background light))
;;      :foreground "firebrick4")
;;     (((background dark))
;;      :foreground "red4"))
;;   "Face used for the completion annotation in the tooltip.")

;; (defface company-tooltip-annotation-selection
;;   '((default :inherit company-tooltip-annotation))
;;   "Face used for the selected completion annotation in the tooltip.")

;; (defface company-scrollbar-fg
;;   '((((background light))
;;      :background "darkred")
;;     (((background dark))
;;      :background "red"))
;;   "Face used for the tooltip scrollbar thumb.")

;; (defface company-scrollbar-bg
;;   '((((background light))
;;      :background "wheat")
;;     (((background dark))
;;      :background "gold"))
;;   "Face used for the tooltip scrollbar background.")

;; (defface company-preview
;;   '((((background light))
;;      :inherit (company-tooltip-selection company-tooltip))
;;     (((background dark))
;;      :background "blue4"
;;      :foreground "wheat"))
;;   "Face used for the completion preview.")

;; (defface company-preview-common
;;   '((((background light))
;;      :inherit company-tooltip-common-selection)
;;     (((background dark))
;;      :inherit company-preview
;;      :foreground "red"))
;;   "Face used for the common part of the completion preview.")

;; (defface company-preview-search
;;   '((((background light))
;;      :inherit company-tooltip-common-selection)
;;     (((background dark))
;;      :inherit company-preview
;;      :background "blue1"))
;;   "Face used for the search string in the completion preview.")

;; (defface company-echo nil
;;   "Face used for completions in the echo area.")

;; (defface company-echo-common
;;   '((((background dark)) (:foreground "firebrick1"))
;;     (((background light)) (:background "firebrick4")))
;;   "Face used for the common part of completions in the echo area.")


;; (custom-set-faces
;;  '(company-preview
;;    ((t (:foreground "darkgray" :underline t))))
;;  '(company-preview-common
;;    ((t (:inherit company-preview))))
;;  '(company-tooltip
;;    ((t (:background "lightgray" :foreground "black"))))
;;  '(company-tooltip-selection
;;    ((t (:background "steelblue" :foreground "white"))))
;;  '(company-tooltip-common
;;    ((((type x)) (:inherit company-tooltip :weight bold))
;;     (t (:inherit company-tooltip))))
;;  '(company-tooltip-common-selection
;;    ((((type x)) (:inherit company-tooltip-selection :weight bold))
;;     (t (:inherit company-tooltip-selection)))))

;; (require 'color)
;; (let ((bg (face-attribute 'default :background)))
;;   (custom-set-faces
;;    `(company-tooltip ((t (:inherit default :background ,(color-lighten-name bg 2)))))
;;    `(company-scrollbar-bg ((t (:background ,(color-lighten-name bg 10)))))
;;    `(company-scrollbar-fg ((t (:background ,(color-lighten-name bg 5)))))
;;    `(company-tooltip-selection ((t (:inherit font-lock-function-name-face))))
;;    `(company-tooltip-common ((t (:inherit font-lock-constant-face))))))

;; (custom-set-faces
;;  '(company-tooltip-common ((t (:underline nil))))
;;  '(company-preview-common ((t (:underline nil))))
;;  '(company-tooltip-common-selection ((t (:underline nil)))))

;; (add-hook 'css-mode-hook
;;           (lambda ()
;;             (set (make-local-variable 'company-backends) '(company-css))))
;; (add-hook 'eshell-mode-hook (lambda () (company-mode -1)))
(global-company-mode)

(require 'company-tern)
(add-to-list 'company-backends 'company-tern)


(when (require 'company-box nil t)
  (add-hook 'company-mode-hook 'company-box-mode)
  (setq company-box-icons-elisp
        (list
         (concat (all-the-icons-material "functions") " ")
         (concat (all-the-icons-material "check_circle") " ")
         (concat (all-the-icons-material "stars") " ")
         (concat (all-the-icons-material "format_paint") " ")))
  (setq company-box-icons-unknown (concat (all-the-icons-material "find_in_page") " "))
  (setq company-box-backends-colors nil)
  )
