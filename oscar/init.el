(server-start)

(defun pbcopy-region (start end)
  "Copies current region into Mac's clipboard using pbcopy"
  (interactive (let ()
                 (unless (mark)
		   (user-error "The mark is not set now, so there is no region"))
                 (list (region-beginning) (region-end))))
  (shell-command-on-region start end "pbcopy"))

(defun ido-recentf-open ()
  "Use `ido-completing-read' to \\[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))

(defun dashboard-configuration ()
  (require 'dashboard)
  (setq dashboard-items '((recents  . 10)
                          (projects . 10)
                          (bookmarks . 5)
                          (registers . 5)
                          (agenda . 5)))
  (setq dashboard-startup-banner 'logo)
  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
  (dashboard-setup-startup-hook))


(defun last-term-buffer (l)
  "Return most recently used term buffer."
  (when l
    (if (eq 'term-mode (with-current-buffer (car l) major-mode))
        (car l)
      (last-term-buffer (cdr l)))))

(defun get-term (arg)
  "Switch to the term buffer last used in another window, or create a new one if none exists, or if the current buffer is already a term.
If you want to switch in the same window pass a prefix argument."
  (interactive "P")
  (let ((b (last-term-buffer (buffer-list))))
    (if (or (not b) (eq 'term-mode major-mode))
        (multi-term)
      (if arg
          (switch-to-buffer b)
        (switch-to-buffer-other-window b)))))

(defun ap/load-doom-theme (theme)
  "Disable active themes and load a Doom theme."
  (interactive (list (intern (completing-read "Theme: "
                                              (->> (custom-available-themes)
                                                   (-map #'symbol-name)
                                                   (--select (string-prefix-p "doom-" it)))))))
  (ap/switch-theme theme)

  (set-face-foreground 'org-indent (face-background 'default)))

(defun ap/switch-theme (theme)
  "Disable active themes and load THEME."
  (interactive (list (intern (completing-read "Theme: "
                                              (->> (custom-available-themes)
                                                   (-map #'symbol-name))))))
  (mapc #'disable-theme custom-enabled-themes)
  (load-theme theme 'no-confirm))

(defun after-package-initializations-customizations ()
  (require 'iso-transl)

  (load-theme 'doom-solarized-light t)

  (setq ido-enable-flex-matching t)
  (setq ido-everywhere t)
  (ido-mode 1)

  (setq visible-bell nil)


  (require 'uniquify)
  (setq uniquify-buffer-name-style 'forward)
  (setq uniquify-separator "/")
  (setq uniquify-after-kill-buffer-p t)    ; rename after killing uniquified
  (setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers

  ;; disable flyspellmode by default for some modes
  (dolist (hook '(nxml-mode-hook))
      (add-hook hook (lambda () (flyspell-mode -1))))

  (global-set-key (kbd "C-.") 'hippie-expand)

  (electric-pair-mode +1)

  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

  (yas-global-mode 1)

   ;; undo-tree-mode
  (global-undo-tree-mode)
  (global-set-key (kbd "C--") 'undo-tree-undo)

  (global-set-key (kbd "S-<up>") 'windmove-up)
  (global-set-key (kbd "S-<down>") 'windmove-down)
  (global-set-key (kbd "S-<left>") 'windmove-left)
  (global-set-key (kbd "S-<right>") 'windmove-right)

  (global-set-key (kbd "C-c r") 'revert-buffer)

  ;; eclipse like jump of line in the middle of it
  (define-key input-decode-map "\e[13;5U" [(control return)]) ;; some
  ;; help for decoding sequence sent by the terminal in Linux
  (global-set-key (kbd "C-<return>") (kbd "C-e C-j"))
  (define-key input-decode-map "\e[13;6U" [(control shift return)])
  (global-set-key (kbd "C-S-<return>") (kbd "C-a <return> C-p"))

  ;; recentf mode
  (recentf-mode t)
  ; 50 files ought to be enough.
  (setq recentf-max-saved-items 50)

  (global-set-key (kbd "C-x f") 'ido-recentf-open)

  ;; multiterm-configuration
  (setq multi-term-program "/bin/bash")
  (setq multi-term-dedicated-select-after-open-p t)
  (setq multi-term-dedicated-skip-other-window-p t)
  (global-set-key (kbd "C-c t") 'get-term)
  (global-set-key (kbd "C-c d") (lambda ()
                                  (interactive)
                                  (require 'multi-term)
                                  (multi-term-dedicated-toggle)))

  (global-set-key (kbd "C-c c") 'pbcopy-region)

  (dashboard-configuration))


(use-package key-chord
  :init
  :custom
  (key-chord-one-key-delay 0.05)
  (key-chord-two-keys-delay 0.10)
  ;;; A 2023 release caused problems and delays. See
  ;;; - https://github.com/emacsorphanage/key-chord/issues/6
  ;;; - https://github.com/emacsorphanage/key-chord/issues/7
  (key-chord-safety-interval-forward 0.1)
  (key-chord-safety-interval-backward 0)
  (key-chord-safety-interval-forward 0)
  :config
  (mapcar (lambda (chord)
            (key-chord-define-global (elt chord 0)
                                     (elt chord 1)))
          [["fj" jump-char-forward]
           ["fh" jump-char-backward]
           ["fk" ace-jump-mode]
           ["jw" mark-word]
           ["jz" repeat]
           ["df" backward-word]
           ["fg" forward-word]
           ["hj" backward-char]
           ["jk" forward-char]
           ["kd" kill-word]
           ["cv" back-to-indentation]
           ["vb" move-end-of-line]
           ["kw" kill-ring-save]
           ["f," ido-switch-buffer-other-window]
           ["f." ido-switch-buffer]
           ["jr" query-replace-regexp]
           ["jx" smex]
           ["jq" join-line]])
  (key-chord-mode 1))

(use-package clojure-mode
  :config (require 'flycheck-clj-kondo)
  :bind
  (:map clojure-mode-map
        ("C-c l" . align-cljlet)))

(use-package flycheck-clj-kondo
  :hook (clojure-mode . flycheck-mode))

;;(use-package paredit-mode)

(use-package clj-refactor
  :hook (clojure-mode . clj-refactor-mode)
  :config
  (cljr-add-keybindings-with-prefix "C-c j"))

(use-package org
  :mode ("\\.org" . org-mode)
  :config
  (setq org-refile-targets '((nil :maxlevel . 9) (("~/work/otm/org-mode/todo.org") :maxlevel . 9)))
    (define-key org-mode-map (kbd "S-<up>") nil)
    (define-key org-mode-map (kbd "S-<down>") nil)
    (define-key org-mode-map (kbd "S-<left>") nil)
    (define-key org-mode-map (kbd "S-<right>") nil)

    (require 'org-trello))

(use-package company
  :config
  (global-company-mode)
  (setq company-idle-delay .5)
  (company-flx-mode +1)
  :bind
  ("TAB" . company-indent-or-complete-common)
  ("C-," . company-complete))

(use-package paredit
  :hook ((emacs-lisp-mode . paredit-mode)
         (eval-expression-minibuffer-setup . paredit-mode)
         (ielm-mode . paredit-mode)
         (lisp-mode . paredit-mode)
         (lisp-interaction-mode . paredit-mode)
         (scheme-mode . paredit-mode)
         (slime-repl-mode . paredit-mode)
         (clojure-mode . paredit-mode)
         (clojurescript-mode . paredit-mode)
         (cider-repl-mode . paredit-mode)
         (cider-mode . paredit-mode)
         (clojure-mode . paredit-mode))
  :bind
  (:map paredit-mode-map
        ("C-S-<left>"  . paredit-backward-slurp-sexp)
        ("C-S-<right>" . paredit-backward-barf-sexp)
        ("C-<left>"    . paredit-forward-barf-sexp)
        ("C-<right>"   . paredit-forward-slurp-sexp)))

(use-package mc-edit-lines
  :init
  (define-key input-decode-map "\e[13;3B" [(control \;)])
  (define-key input-decode-map "\e[13;3A" [(control \:)])
  :bind
  ("C-c m" . mc/edit-lines)
  ("C-;" . mc/mark-next-like-this)
  ("C-:" . mc/mark-previous-like-this)
  ("C-c ;" . mc/mark-all-like-this))

(use-package expand-region
  :init
  (define-key input-decode-map "\e[1;10A" [(meta shift up)])
  (define-key input-decode-map "\e[1;10B" [(meta shift down)])
  :bind
  ("M-S-<up>" . er/expand-region)
  ("M-S-<down>" . er/contract-region))

(use-package jump-char
  :bind
  ("C-c C-f" . jump-char-forward)
  ("C-c C-b" . jump-char-backward))

(use-package ag
  :bind
  ("C-c a r" . ag-regexp)
  ("C-c a p" . ag-project-regexp))

(use-package gptel
  :config
  (add-to-list 'gptel-directives
               '(emacs . "You are an Emacs maven and Elisp expertliving in Emacs. Respondx concisely.")
               t)
  (add-to-list 'gptel-directives
               '(command . "You translate the prompt into a valid GNU/Linux command.")
               t)

  :bind
  ("C-c RET" . gptel-send)
  (:map gptel-mode-map
        ("C-c C-c" . gptel-abort)))


(use-package transient
  :init
  (transient-define-prefix cc/isearch-menu ()
    "isearch Menu"
    [["Edit Search String"
      ("e"
       "Edit the search string (recursive)"
       isearch-edit-string
       :transient nil)
      ("w"
       "Pull next word or character word from buffer"
       isearch-yank-word-or-char
       :transient nil)
      ("s"
       "Pull next symbol or character from buffer"
       isearch-yank-symbol-or-char
       :transient nil)
      ("l"
       "Pull rest of line from buffer"
       isearch-yank-line
       :transient nil)
      ("y"
       "Pull string from kill ring"
       isearch-yank-kill
       :transient nil)
      ("t"
       "Pull thing from buffer"
       isearch-forward-thing-at-point
       :transient nil)]

     ["Replace"
      ("q"
       "Start ‘query-replace’"
       isearch-query-replace
       :if-nil buffer-read-only
       :transient nil)
      ("x"
       "Start ‘query-replace-regexp’"
       isearch-query-replace-regexp
       :if-nil buffer-read-only     
       :transient nil)]]
    
    [["Toggle"
      ("X"
       "Toggle regexp searching"
       isearch-toggle-regexp
       :transient nil)
      ("S"
       "Toggle symbol searching"
       isearch-toggle-symbol
       :transient nil)
      ("W"
       "Toggle word searching"
       isearch-toggle-word
       :transient nil)
      ("F"
       "Toggle case fold"
       isearch-toggle-case-fold
       :transient nil)
      ("L"
       "Toggle lax whitespace"
       isearch-toggle-lax-whitespace
       :transient nil)]
     
     ["Misc"
      ("o"
       "occur"
       isearch-occur
       :transient nil)]]))

(define-key isearch-mode-map (kbd "<f2>") 'cc/isearch-menu)
