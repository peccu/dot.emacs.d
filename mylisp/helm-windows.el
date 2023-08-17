;;; helm-windows.el --- helm support for windows.el. -*- lexical-binding: t -*-

;; Copyright (C) 2021 ~ peccu <peccul@gmail.com>

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Sample Config:
;; (require 'helm-windows)
;; (define-key win:switch-map "=" 'helm-windows)

;;; Code:
(require 'helm)
(require 'windows)

(defconst helm-windows-candidate-format " (%%c)%%s %%-%ds [%%s]")
(defconst helm-windows-pick-candidate-pattern "^ (\\(.\\))")

;; rewrite from anything-c-source-other-windows
;; http://i-yt.info/?date=20090321#p01
;; https://www.emacswiki.org/emacs/AnythingSources#h5o-54
(defun helm-windows-create-candidates ()
  (win:store-config win:current-config)
  (let ((i 1)
        (candidates (list))
        (form (format helm-windows-candidate-format (+ win:names-maxl 2))))
    (while (< i win:max-configs)
      (add-to-list 'candidates
                   (if (aref win:configs i)
                       (format form
                               (+ win:base-key i) ;number or char
                               (cond              ;window state
                                ((= i win:current-config) "*") ;current window
                                ((= i win:last-config) "+")    ;previous window
                                (t " "))                       ;other
                               (format "%s" (aref win:names-prefix i)) ;window name if it exists
                               (aref win:names i)) ;buffer names
                     (format form (+ win:base-key i) " " "" "")))
      (setq i (1+ i)))
    (sort candidates 'string<)))

(defvar helm-source-windows
  (helm-build-sync-source "helm Windows"
    :candidates 'helm-windows-create-candidates
    :action (helm-make-actions
             "Switch to Window"
             #'helm-windows-switch-to-window)))

(defun helm-windows-switch-to-window (candidate)
  (when (string-match helm-windows-pick-candidate-pattern candidate)
    (let ((last-command-char (if (= win:base-key ?0)
                                 (string-to-number (match-string 1 candidate))
                               (string-to-char (match-string 1 candidate))))) ;win:base-key should be ?`
      (call-interactively 'win-switch-to-window))))

;;;###autoload
(defun helm-windows ()
  "list windows."
  (interactive)
  (helm :sources '(helm-source-windows)
        :window "*helm windows*"))
(provide 'helm-windows)
