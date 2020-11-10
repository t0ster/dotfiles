;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!
;; (after! core-packages
;;     (add-to-list 'comp-deferred-compilation-black-list "\\.local/autoloads\\.el")
;;     (add-to-list 'comp-deferred-compilation-black-list "org-agenda"))


(setenv "TZ" "Europe/Kiev")


;; (after! comp
;;   (setq comp-deferred-compilation-black-list (append '("org-agenda"
;;                                                        "\\.local/straight/build/org-ref"
;;                                                        "\\.local/straight/build/dap-mode"
;;                                                        "\\.local/straight/build/parinfer"
;;                                                        ;; "pdf-.+el"
;;                                                        "explain-pause-mode") comp-deferred-compilation-black-list)))

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Roman Dolgyi"
      user-mail-address "roman@btsolutions.co")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
;; (setq doom-font (font-spec :family "Operator Mono" :size 14))
;; (setq doom-font (font-spec :family "Jetbrains Mono" :size 13))
(setq doom-font (font-spec :family "Fira Code" :size 13))
;; (setq doom-font (font-spec :family "Iosevka" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-monokai-pro)
;; (setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Persist frame size and position
;; (when-let (dims (doom-store-get 'last-frame-size))
;;   (cl-destructuring-bind ((left . top) width height fullscreen) dims
;;     (setq initial-frame-alist
;;           (append initial-frame-alist
;;                   `((left . ,left)
;;                     (top . ,top)
;;                     (width . ,width)
;;                     (height . ,height)
;;                     (fullscreen . ,fullscreen))))))
;; (defun save-frame-dimensions ()
;;   (doom-store-put 'last-frame-size
;;                   (list (frame-position)
;;                         (frame-width)
;;                         (frame-height)
;;                         (frame-parameter nil 'fullscreen))))
;; (add-hook 'kill-emacs-hook #'save-frame-dimensions)
;; (toggle-frame-fullscreen)

;; Switch to the new window after splitting
(setq evil-split-window-below t
      evil-vsplit-window-right t)

;; Display doc in company popup
;; (after! company
;;   (company-quickhelp-mode))

;; Command to run hy expression and get back to original window
(defun hy-eval ()
  (interactive)
  (hy-shell-eval-current-form)
  (evil-window-prev 1))
(map! :map hy-mode-map :nv "SPC m e" #'hy-eval)

;; Fixing some projectile issues
(setq projectile-project-root-files '(".projectile"))
(setq projectile-project-root-files-functions #'(projectile-root-top-down
                                                 projectile-root-top-down-recurring
                                                 projectile-root-bottom-up
                                                 projectile-root-local))
;; (use-package! pipenv
;;   :hook (python-mode . pipenv-mode))

;; Automatically activate pipenv on buffer switch
(defun pipenv-switch-hook (_frame)
  (when (not (and (string-prefix-p "*" (buffer-name))
                  (string-suffix-p "*" (buffer-name))))
      (when (and (derived-mode-p 'python-mode 'hy-mode)
                 (not (equal (projectile-project-name) pyvenv-virtual-env-name)))
            (pipenv-deactivate)
            (pipenv-activate))))
;; (add-hook 'window-buffer-change-functions #'pipenv-switch-hook)

;; Rerun run project previous command
(map! :map prog-mode-map :leader "r" (cmd!
                                      (let ((compilation-read-command))
                                        (projectile-run-project nil))))

;; Org-mode
;; deft
(setq deft-recursive t)
;; (setq deft-use-filter-string-for-filename t)
;; (setq deft-strip-summary-regexp "\\([\n	]\\|^#\\+[[:upper:]_]+:.*$\\)")
(setq deft-strip-summary-regexp "\\([\n	]\\|^#\\+.+:.*$\\)")
;; (setq deft-default-extension "org")
(setq deft-directory "~/org/roam")
;; org-journal
(setq org-journal-date-prefix "#+TITLE: ")
;; (setq org-journal-date-prefix "* ")
(setq org-journal-file-format "%Y-%m-%d.org")
(setq org-journal-dir "~/org/roam")
(setq org-journal-date-format "%A, %d %B %Y")
;; org-roam-server
(setq org-roam-server-host "127.0.0.1"
      org-roam-server-port 8099
      org-roam-server-export-inline-images t
      org-roam-server-authenticate nil
      org-roam-server-network-poll t
      org-roam-server-network-arrows nil
      org-roam-server-network-label-truncate t
      org-roam-server-network-label-truncate-length 60
      org-roam-server-network-label-wrap-length 20)
(after! org-journal
  (setq org-journal-carryover-items ""))

(defun custom-group-fn (item)
  (org-super-agenda--when-with-marker-buffer (org-super-agenda--get-marker item)
    (let ((group-name nil))
      (if (org-up-heading-safe)
          (if (string= (org-get-todo-state) "PROJ")
              (setq group-name (org-get-heading 'no-tags 'no-todo)))
        ;; (if (org-down-element)
        ;;     (setq group-name (org-get-heading 'no-tags 'no-todo)))
        group-name))))

(setq org-agenda-custom-commands
      '(("a" "Agenda" ((agenda))
         ;; ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo '("INBOX")))
         ((org-super-agenda-groups '((:name "Startup 🌞" :habit t)
                                     (:name "Deadline" :deadline today :deadline past)
                                     (:auto-map custom-group-fn)
                                     (:name "Deadline Soon" :deadline future)))
                                     ;; (:discard (:anything t))))
          (org-agenda-start-day "today")
          (org-agenda-span 'day)
          (org-agenda-skip-scheduled-if-done t)
          (org-agenda-skip-deadline-if-done t)))
        ("ta" "TODO All" ((org-ql-block '(todo))) ;; and exclude PROJ with children
         ((org-super-agenda-groups '((:auto-map custom-group-fn :habit nil)
                                     (:name "INBOX" :todo "INBOX" :order 100)))))
        ("tt" "TODO" ((org-ql-block '(todo "TODO")))
         ((org-super-agenda-groups '((:auto-map custom-group-fn :habit nil)))))
        ("t2" "TODO by Tags" ((org-ql-block '(todo "TODO")))
         ((org-super-agenda-groups '((:auto-tags t :habit nil)))))
        ("tn" "TODO Next" ((org-ql-block '(and (todo)
                                               (or (ancestors (scheduled :to today))
                                                   (scheduled :to today))))))))
(setq org-agenda-prefix-format "%t %s")
;; (setq org-agenda-prefix-format " %i %?-30(concat \"[ \"(org-format-outline-path (org-get-outline-path)) \" ]\") ")
(after! org
  (setq org-todo-keywords '((sequence "TODO(t)" "INBOX(i)" "PROJ(p)" "STRT(s)" "WAIT(w)" "HOLD(h)" "|" "DONE(d)" "KILL(k)")
                            (sequence "[ ](T)" "[-](S)" "[?](W)" "|" "[X](D)"))))

(setq org-log-done 'time)


(defun org-journal-standup-entry ()
  (interactive)
  (let ((org-journal-after-entry-create-hook))
    (add-hook 'org-journal-after-entry-create-hook #'(lambda ()
                                                       (org-insert-subheading nil)
                                                       (insert "Что я сделал вчера?")
                                                       (org-insert-heading)
                                                       (insert "Что я буду делать сегодня?")
                                                       (org-insert-heading)
                                                       (insert "Что мне мешает?")
                                                       (org-insert-heading)
                                                       (insert "Что либо на уме о чем еще стоит написать?")))
    (org-journal-new-entry nil)))

(map! :map evil-window-map
      ;; Navigation
      "C-<left>"     #'evil-window-left
      "C-<down>"     #'evil-window-down
      "C-<up>"       #'evil-window-up
      "C-<right>"    #'evil-window-right
      "<left>"     #'evil-window-left
      "<down>"     #'evil-window-down
      "<up>"       #'evil-window-up
      "<right>"    #'evil-window-right)

;; (map! :map org-super-agenda-header-map "j" 'org-agenda-next-line)
;; (map! :map org-super-agenda-header-map "k" 'org-agenda-previous-line)
;; (map! :map org-super-agenda-header-map "h" 'evil-backward-char)
;; (map! :map org-super-agenda-header-map "l" 'evil-forward-char)
;; (map! :map org-super-agenda-header-map "w" 'evil-forward-word-begin)
;; (map! :map org-super-agenda-header-map "b" 'evil-backward-word-begin)
(map! :map org-super-agenda-header-map "j" nil)
(map! :map org-super-agenda-header-map "k" nil)
(map! :map org-super-agenda-header-map "h" nil)
(map! :map org-super-agenda-header-map "l" nil)
(map! :map org-super-agenda-header-map "w" nil)
(map! :map org-super-agenda-header-map "b" nil)
(map! :map evil-org-agenda-mode-map :m "F" 'org-agenda-follow-mode)

(add-hook 'org-journal-mode-hook #'org-roam-mode)
(after! org
  (org-super-agenda-mode))

;; Fix Company bindings (for some reason they were not working in emacs-lisp-mode)
(map! :map evil-insert-state-map :mode company-mode :i "C-j" 'company-select-next)
(map! :map evil-insert-state-map :mode company-mode :i "C-k" 'company-select-previous)

;; (setq lsp-ui-peek-always-show t)
(setq lsp-ui-peek-fontify 'always)

(map! :leader "s r" 'counsel-evil-marks)
(setq warning-suppress-types '((undo discard-info)))

;; Default behavior for <tab> in org-mode
(after! evil-org
  (remove-hook 'org-tab-first-hook #'+org-cycle-only-current-subtree-h))

(after! evil-snipe
  (setq evil-snipe-scope 'visible))

(map! :after evil-snipe
      :map evil-snipe-parent-transient-map
      "C-," (cmd! (require 'evil-easymotion)
                  (call-interactively
                   (evilem-create #'evil-snipe-repeat-reverse
                                  :bind ((evil-snipe-scope 'whole-buffer)
                                         (evil-snipe-enable-highlight)
                                         (evil-snipe-enable-incremental-highlight))))))

(map! "s-k" 'kill-current-buffer)
;; (add-to-list 'default-frame-alist '(inhibit-double-buffering . t))

(use-package! hl-line+
  :load-path "3rd/hl-line+"
  :config
  (hl-line-when-idle-interval 0.3)
  (toggle-hl-line-when-idle 1))

;; (use-package! fira-code-mode
;;   :load-path "3rd")

;; (use-package! fira-code-mode
;;   :hook prog-mode)

(with-eval-after-load 'lsp-mode
  (setq lsp-pyls-plugins-pycodestyle-enabled nil
        lsp-pyls-plugins-pyflakes-enabled nil
        lsp-pyls-plugins-autopep8-enabled nil))


;; TODO: Switch lsp after buffer switch
;; (lsp--suggest-project-root)
;; (lsp)

;; (setq lsp-eslint-server-command
;;    '("node"
;;      "/Users/t0ster/Documents/Workspace/vscode-eslint/server/out/eslintServer.js"
;;      "--stdio"))

(use-package! flycheck-prospector
  :after-call python-mode-local-vars-hook
  ;; :after-call lsp-flycheck-add-mode
  ;; :after lsp-mode
  ;; lsp-diagnostics-updated-hook
  :config
  (flycheck-prospector-setup)
  (add-hook! 'lsp-after-open-hook :append (flycheck-add-next-checker 'lsp 'python-prospector))
  ;; :init  (add-hook! 'lsp-mode-hook :append #'flycheck-prospector-setup)
  :load-path "3rd/flycheck-prospector")


(use-package! nov
  :mode ("\\.epub\\'" . nov-mode)
  :config
  (setq nov-save-place-file (concat doom-cache-dir "nov-places")))

(setq mac-right-option-modifier 'meta)
(use-package! russian-mac)

(use-package org-roam-bibtex
  :after org-roam
  :hook (org-roam-mode . org-roam-bibtex-mode)
  :bind (:map org-mode-map
         (("C-c n a" . orb-note-actions))))

(map! :leader "n b" 'helm-bibtex)

(setq
 bibtex-completion-notes-path "~/org/roam"
 bibtex-completion-bibliography '("~/org/My Library.bib")
 bibtex-completion-library-path '("~/org/pdfs")
 bibtex-completion-pdf-field "file"
 bibtex-completion-notes-template-multiple-files
 (concat
  "#+TITLE: ${title}\n"
  "#+ROAM_KEY: cite:${=key=}\n"
  "* Notes\n"
  ":PROPERTIES:\n"
  ":Custom_ID: ${=key=}\n"
  ":NOTER_DOCUMENT: %(orb-process-file-field \"${=key=}\")\n"
  ":AUTHOR: ${author-abbrev}\n"
  ":JOURNAL: ${journaltitle}\n"
  ":DATE: ${date}\n"
  ":YEAR: ${year}\n"
  ":DOI: ${doi}\n"
  ":URL: ${url}\n"
  ":END:\n\n"))

(use-package! org-ref
  :after org-roam
  :config
  (setq
   org-ref-completion-library 'org-ref-ivy-cite
   org-ref-get-pdf-filename-function 'org-ref-get-pdf-filename-helm-bibtex
   org-ref-default-bibliography (list "~/org/My Library.bib")
   org-ref-note-title-format "* TODO %y - %t\n :PROPERTIES:\n  :Custom_ID: %k\n  :NOTER_DOCUMENT: %F\n :ROAM_KEY: cite:%k\n  :AUTHOR: %9a\n  :JOURNAL: %j\n  :YEAR: %y\n  :VOLUME: %v\n  :PAGES: %p\n  :DOI: %D\n  :URL: %U\n :END:\n\n"
   org-ref-notes-directory "~/org/roam"
   org-ref-notes-function 'orb-edit-notes))

(setq org-roam-bibtex-preformat-keywords
   '("=key=" "title" "url" "file" "author-or-editor" "keywords"))
(setq orb-templates
      '(("r" "ref" plain (function org-roam-capture--get-point)
              ""
              :file-name "${slug}"
              :head "#+TITLE: ${=key=}: ${title}\n#+ROAM_KEY: ${ref}

- tags ::
- keywords :: ${keywords}

\n* ${=key=}\n:PROPERTIES:\n:Custom_ID: ${=key=}\n:URL: ${url}\n:AUTHOR: ${author-or-editor}\n:NOTER_DOCUMENT: %(orb-process-file-field \"${=key=}\")\n:NOTER_PAGE: \n:END:\n** Annotations\n\n"

              :unnarrowed t)))

;; Use prettier for html
(set-formatter! 'prettier-html "prettier --parser html" :modes '(html-mode web-mode))


;; native-comp fixes
(defun jsons-remove-buffer ())
;; (use-package! simple)
;; (defmacro parinfer-save-excursion (&rest body))
;; (defmacro save-mark-and-excursion (&rest body)
;;   "Like `save-excursion', but also save and restore the mark state.
;; This macro does what `save-excursion' did before Emacs 25.1."
;;   (declare (indent 0) (debug t))
;;   (let ((saved-marker-sym (make-symbol "saved-marker")))
;;     `(let ((,saved-marker-sym (save-mark-and-excursion--save)))
;;        (unwind-protect
;;            (save-excursion ,@body)
;;          (save-mark-and-excursion--restore ,saved-marker-sym)))))
(defun org-ql-search ())
(defun org-ql-search-directories-files ())
;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq python-shell-interpreter "ipython")
(setq python-shell-interpreter-args "-i --simple-prompt --no-color-info")

;; (use-package! json-snatcher
;;   :after-call kill-buffer-hook)

(after! flyspell
  (ispell-hunspell-add-multi-dic "ru_RU,en_US")
  (setq ispell-dictionary "ru_RU,en_US"))


(setq mouse-autoselect-window t)

(use-package! evil-replace-with-register
  :config (evil-replace-with-register-install))
(use-package! evil-textobj-line)

(map! :map web-mode-map :i "M-/" 'dabbrev-expand)

(setq counsel-rg-base-command '("rg" "-M" "0" "--with-filename" "--no-heading" "--line-number" "--color" "never" "%s"))

(after! core-ui
  (fringe-mode '(12 . 6))
  (set-face-foreground 'line-number "#949494"))

;; evil-mc fix
;; https://github.com/gabesoft/evil-mc/issues/83
(with-eval-after-load 'evil-mc
  (setq evil-mc-cursor-variables
        (mapcar
          (lambda (s)
            (remove 'register-alist
                    (remove 'evil-markers-alist
                            (remove evil-was-yanked-without-register s))))
          evil-mc-cursor-variables)))



(after! tramp-sh
  (add-to-list 'tramp-remote-path "/c/Users/jazz/AppData/Roaming/Python/Python38/Scripts")
  (add-to-list 'tramp-remote-path "/c/Python38")
  (add-to-list 'tramp-remote-path "/c/Python38/Scripts"))

(setq org-startup-with-latex-preview t)
(use-package! org-fragtog
  :hook (org-mode . org-fragtog-mode))
