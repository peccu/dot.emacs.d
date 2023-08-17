#!/bin/bash
# host(WSL) to container
rsync \
    --exclude-from=$HOME/.emacs.d/.gitignore \
    -auvz \
    ~/.emacs.d/ \
    /aws/.emacs.d/
# container to host(WSL)
rsync \
    --exclude-from=$HOME/.emacs.d/.gitignore \
    -auvz \
    /aws/.emacs.d/ \
    ~/.emacs.d/
