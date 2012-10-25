(add-to-list 'auto-mode-alist '("\.cljs$" . clojure-mode))

(define-key lisp-mode-shared-map (kbd "<C-tab>") 'lisp-complete-symbol)

(add-hook 'nrepl-mode-hook
          (lambda ()
            (define-key nrepl-interaction-mode-map (kbd "C-,")
              'nrepl-complete)))

(add-hook 'nrepl-interaction-mode-hook
  'nrepl-turn-on-eldoc-mode)
