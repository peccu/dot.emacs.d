(require 'lsp-python-ms)
;; docker run --rm -it mcr.microsoft.com/dotnet/core/sdk:3.0
;; git clone https://github.com/Microsoft/python-language-server.git
;; cd python-language-server/src/LanguageServer/Impl/
;; dotnet publish -c Release -r osx-x64
;; tar czf python-lsp.tar.gz output/bin/Release/osx-x64/
(setq lsp-python-ms-executable
      "~/bin/python-language-server/output/bin/Release/osx-x64/publish/Microsoft.Python.LanguageServer")
(setq lsp-python-ms-python-executable-cmd "python3")
(add-hook 'python-mode-hook #'lsp) ; or lsp-deferred
;; (setq lsp-python-ms-extra-paths '())
