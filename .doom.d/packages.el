;;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.

;; Disable native compilation for some packages
(dolist (entry (list "\\.local/autoloads"
                     "evil-collection-vterm\\.el"
                     "site-start"
                     (concat (regexp-quote doom-local-dir) ".*/org-agenda")
                     (concat (regexp-quote doom-local-dir) ".*/org-ref")
                     (concat (regexp-quote doom-local-dir) ".*/dap-mode")
                     (concat (regexp-quote doom-local-dir) ".*/parinfer")
                     ;; "pdf-.+el"
                     (concat (regexp-quote doom-local-dir) ".*/explain-pause-mode")))
  (add-to-list 'comp-deferred-compilation-black-list entry))

;; This is needed for bin/doom build command
(package! parinfer :recipe (:no-native-compile t))

(package! org-fragtog :recipe (:host github :repo "io12/org-fragtog"))

;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;(package! some-package)
;; (package! company-quickhelp)
(package! org-roam-server)
(package! org-roam-bibtex
  :recipe (:host github :repo "org-roam/org-roam-bibtex"))
(package! helm-bibtex)

;; When using org-roam via the `+roam` flag
(unpin! org-roam company-org-roam)

;; When using bibtex-completion via the `biblio` module
(unpin! bibtex-completion helm-bibtex ivy-bibtex)

(unpin! dap-mode)

(unpin! lsp-mode)
(unpin! lsp-ui)
(unpin! lsp-ivy)
(package! lsp-treemacs)
(unpin! lsp-treemacs)
(unpin! dap-mode)

(package! org-ref)

(package! org-ql)
(package! command-log-mode)
(package! russian-mac :recipe (:host github :repo "juev/russian-mac"))
(package! fira-code-mode)
(package! nov)
;; (package! flycheck-prospector)

(package! evil-replace-with-register
  :recipe (:host github :repo "Dewdrops/evil-ReplaceWithRegister"))
(package! evil-textobj-line
  :recipe (:host github :repo "emacsorphanage/evil-textobj-line"))

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;(package! this-package
;  :recipe (:host github :repo "username/repo"
;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;(unpin! pinned-package)
;; ...or multiple packages
;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;(unpin! t)
