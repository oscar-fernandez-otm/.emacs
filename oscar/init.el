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

(server-start)
(load-theme 'zenburn)
