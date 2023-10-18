(server-start)


(fset 'remove-validate
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote (":as swaggerOCswagger/OCOC[1;3A" 0 "%d")) arg)))



(defun ido-recentf-open ()
  "Use `ido-completing-read' to \\[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))

(defun org-mode-configuration ()
  (setq org-refile-targets '((nil :maxlevel . 9)
                             (("~/work/otm/org-mode/todo.org") :maxlevel . 9)))

  (define-key org-mode-map (kbd "S-<up>") nil)
  (define-key org-mode-map (kbd "S-<down>") nil)
  (define-key org-mode-map (kbd "S-<left>") nil)
  (define-key org-mode-map (kbd "S-<right>") nil))

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

(defun after-package-initializations-customizations ()
  (require 'iso-transl)
  (require 'org-trello)
  (load-theme 'zenburn t)

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

  (global-company-mode)
  (global-set-key (kbd "TAB") #'company-indent-or-complete-common)
  (setq company-idle-delay .5)
  (with-eval-after-load 'company
    (company-flx-mode +1))

  ;; paredit
  (require 'paredit)
  (define-key paredit-mode-map (kbd "C-S-<left>") 'paredit-backward-slurp-sexp)
  (define-key paredit-mode-map (kbd "C-S-<right>") 'paredit-backward-barf-sexp)
  (define-key paredit-mode-map (kbd "C-<left>") 'paredit-forward-barf-sexp)
  (define-key paredit-mode-map (kbd "C-<right>") 'paredit-forward-slurp-sexp)

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

  ;; use company mode for autocompletion
  (global-company-mode)
  (global-set-key (kbd "C-,") 'company-complete)

  ;; multiple cursors
  (global-set-key (kbd "C-c m") 'mc/edit-lines)
  (define-key input-decode-map "\e[13;3B" [(control \;)])
  (global-set-key (kbd "C-;") 'mc/mark-next-like-this)
  (define-key input-decode-map "\e[13;3A" [(control \:)])
  (global-set-key (kbd "C-:") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c ;") 'mc/mark-all-like-this)

  ;; expand region, used cat -v to see what alt-ship-up is mapped to
  (define-key input-decode-map "\e[1;10A" [(meta shift up)])
  (define-key input-decode-map "\e[1;10B" [(meta shift down)])

  (global-set-key (kbd "M-S-<up>") 'er/expand-region)
  (global-set-key (kbd "M-S-<down>") 'er/contract-region)

  ;; jump-char
  (global-set-key (kbd "C-c C-f") 'jump-char-forward)
  (global-set-key (kbd "C-c C-b") 'jump-char-backward)

  ;; multiterm-configuration
  (setq multi-term-program "/bin/bash")
  (setq multi-term-dedicated-select-after-open-p t)
  (setq multi-term-dedicated-skip-other-window-p t)
  (global-set-key (kbd "C-c t") 'get-term)
  (global-set-key (kbd "C-c d") (lambda ()
                                  (interactive)
                                  (require 'multi-term)
                                  (multi-term-dedicated-toggle)))

  ;; ag configuration
  (global-set-key (kbd "C-c a r") 'ag-regexp)
  (global-set-key (kbd "C-c a p") 'ag-project-regexp)


  ;; enable paredit
  (autoload 'enable-paredit-mode "paredit"
  "Turn on pseudo-structural editing of Lisp code."
  t)
  (add-hook 'emacs-lisp-mode-hook       'enable-paredit-mode)
  (add-hook 'lisp-mode-hook             'enable-paredit-mode)
  (add-hook 'clojure-mode-hook          #'paredit-mode)
  (add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
  (add-hook 'scheme-mode-hook           'enable-paredit-mode)

  (org-mode-configuration)

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
