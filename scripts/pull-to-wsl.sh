#!/bin/bash
rsync \
    --exclude-from=$HOME/.emacs.d/.gitignore \
    -auvz \
    ~/.emacs.d/ \
    /aws/.emacs.d/
