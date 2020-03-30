(unless (package-installed-p 'leaf)
  (package-refresh-contents)
  (package-install 'leaf))
