(add-to-list 'auto-mode-alist '("\.cljs$" . clojure-mode))

(define-key lisp-mode-shared-map (kbd "<C-tab>") 'lisp-complete-symbol)

(add-hook 'nrepl-mode-hook
          (lambda ()
            (setq nrepl-connected-hook (reverse nrepl-connected-hook)) ;; Temporary hack to solve: https://github.com/kingtim/nrepl.el/issues/168
            (define-key nrepl-interaction-mode-map (kbd "C-,")
              'nrepl-complete)))


(add-hook 'nrepl-mode-hook 'paredit-mode)

(add-hook 'nrepl-interaction-mode-hook
  'nrepl-turn-on-eldoc-mode)
