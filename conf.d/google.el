;;; マイナーモードとして使いたいならば以下の設定
;; (setq google-this-keybind (kbd "C-x g"))
;; (google-this-mode 1)
(require 'google-this)
;; (setq google-this-location-suffix "co.jp")
;; (defun google-this-url () "URL for google searches."
;;   ;; 100件/日本語ページ/5年以内ならこのように設定する
;;   (concat google-this-base-url google-this-location-suffix
;;           "/search?q=%s&hl=ja&num=100&as_qdr=y5&lr=lang_ja"))
(global-set-key (kbd "M-g M-g") 'google-this)
