(when (or
       peccu-p
       win-env-p
       wsl-p
       )
(global-set-key "\C-h" 'delete-backward-char)
(global-set-key (kbd "<M-delete>") 'delete-region)
)
