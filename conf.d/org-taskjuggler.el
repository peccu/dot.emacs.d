(when (or
       ;; peccu-p
       ;; win-env-p
       ;; wsl-p
       )
  ;; ;; add contrib for ox-taskjuggler
  ;; ;; with downlowded from https://orgmode.org
  ;; (add-to-list 'load-path (concat user-emacs-directory "lisp/org/contrib/lisp"))
  ;; need sudo gem install taskjuggler

  ;; https://github.com/emacsmirror/org/blob/master/contrib/lisp/ox-taskjuggler.el
  ;; https://orgmode.org/worg/exporters/taskjuggler/ox-taskjuggler.html
  ;; http://taskjuggler.org/tj3/manual/toc.html
  (eval-after-load "org"
    (progn
      (require 'ox-taskjuggler)
      ;; {scale day width 5000}をtaskreport plan のcolumn chartに追加する
      ;; completeを planのcolumnsに追加する
      (setq org-taskjuggler-default-reports
            '("textreport report \"Plan\" {
  formats html
  header '== %title =='

  center -8<-
    [#Plan Plan] | [#Resource_Allocation Resource Allocation]
    ----
    === Plan ===
    <[report id=\"plan\"]>
    ----
    === Resource Allocation ===
    <[report id=\"resourceGraph\"]>
  ->8-
}

# A traditional Gantt chart with a project overview.
taskreport plan \"\" {
  headline \"Project Plan\"
  columns bsi, name, start, end, effort, complete, chart {scale day width 5000}
  loadunit shortauto
  hideresource 1
}
leaves holiday \"Christmas\" 2011-12-24 +3d,
       holiday \"New Year\" 2011-12-31 +3d

# A graph showing resource allocation. It identifies whether each
# resource is under- or over-allocated for.
resourcereport resourceGraph \"\" {
  headline \"Resource Allocation Graph\"
  columns no, name, effort, weekly
  loadunit shortauto
  hidetask ~(isleaf() & isleaf_())
  sorttasks plan.start.up
}"))
      (setq org-taskjuggler-valid-resource-attributes
            '(limits vacation shift booking efficiency journalentry rate workinghours flags leaves))

      ;;     ;; http://blog.ichiroc.in/entry/2010/05/16/000500#
      ;;     ;; New function
      ;;     (defun org-taskjuggler-get-random-id ()
      ;;       (concat "id" (number-to-string (random 100000000))))
      ;;     ;; Override
      ;;     ;; 追記:2010/05/17
      ;;     ;; 元プログラムが task_id property を考慮してないようだったので、
      ;;     ;; 考慮するように修正。
      ;;     ;; これで BLOCKER 等に task id を指定しても無視されなくなる。
      ;;     (defun org-taskjuggler-get-unique-id (item unique-ids)
      ;;       "Return a unique id for an ITEM which can be a task or a resource.
      ;; The id is derived from the headline and made unique against
      ;; UNIQUE-IDS. If the first part of the headline is not unique try to add
      ;; more parts of the headline or finally add more underscore characters (\"_\")."
      ;;       (let* (
      ;;              (task-id (cdr (assoc "task_id" item)))
      ;;              (headline (cdr (assoc "headline" item)))
      ;;              (parts (split-string headline))
      ;;              (id (let *1
      ;;                    (t potential-id)))))
      ;;       (while (member id unique-ids)
      ;;         (setq id (org-taskjuggler-get-random-id)))
      ;;       id))

      t))
  )
