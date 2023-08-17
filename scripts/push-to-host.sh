#!/bin/bash
rsync \
    --exclude-from=$HOME/.emacs.d/.gitignore \
    -auvz \
    /aws/.emacs.d/ \
    ~/.emacs.d/
