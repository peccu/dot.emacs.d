;; ;; add contrib for ox-taskjuggler
;; (add-to-list 'load-path "~/.emacs.d/lisp/org/contrib/lisp")
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
    t))
