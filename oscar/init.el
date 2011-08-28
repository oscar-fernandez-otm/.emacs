(global-set-key (kbd "C-.") 'hippie-expand)

(eval-after-load 'paredit
  '(progn
    (define-key paredit-mode-map (kbd "C-S-<left>") 'paredit-backward-slurp-sexp)
    (define-key paredit-mode-map (kbd "C-S-<right>") 'paredit-backward-barf-sexp)))


(server-start)
(load-theme 'zenburn)
