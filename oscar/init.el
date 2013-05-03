(global-set-key (kbd "C-.") 'hippie-expand)

(eval-after-load 'paredit
  '(progn
    (define-key paredit-mode-map (kbd "C-S-<left>") 'paredit-backward-slurp-sexp)
    (define-key paredit-mode-map (kbd "C-S-<right>") 'paredit-backward-barf-sexp)))

(require 'undo-tree)
(global-undo-tree-mode)
(global-set-key (kbd "C--") 'undo-tree-undo)

(global-set-key (kbd "C-<return>") (kbd "C-e C-j"))
(global-set-key (kbd "C-S-<return>") (kbd "C-a <return> C-p"))

(require 'recentf)
(recentf-mode t)

; 50 files ought to be enough.
(setq recentf-max-saved-items 50)

(defun ido-recentf-open ()
  "Use `ido-completing-read' to \\[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))

(global-set-key (kbd "C-x f") 'ido-recentf-open)

(server-start)
(load-theme 'zenburn t)

(eval-after-load 'auto-complete-autoloads
  '(progn
     (require 'auto-complete-config)
     (ac-config-default)))

;; multiple cursors
(global-set-key (kbd "C-c C-m") 'mc/edit-lines)
(global-set-key (kbd "C-:") 'mc/mark-next-like-this)
(global-set-key (kbd "C-;") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-:") 'mc/mark-all-like-this)

;; expand region
(global-set-key (kbd "M-S-<up>") 'er/expand-region)
(setq expand-region-contract-fast-key "<down>")
