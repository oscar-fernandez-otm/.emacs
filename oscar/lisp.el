(add-hook 'after-init-hook 'lisp-customizations)

(defun lisp-customizations ()

  (add-to-list 'auto-mode-alist '("\.cljs$" . clojure-mode))

  (define-key lisp-mode-shared-map (kbd "<C-tab>") 'lisp-complete-symbol)

  (require 'ac-nrepl)
  (add-hook 'nrepl-repl-mode-hook 'ac-nrepl-setup)
  (add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)
  (eval-after-load "auto-complete"
    '(add-to-list 'ac-modes 'nrepl-mode))

  (add-hook 'nrepl-interaction-mode-hook
            (lambda ()
              (define-key nrepl-interaction-mode-map (kbd "C-,")
                'nrepl-indent-and-complete-symbol)))


  (add-hook 'nrepl-repl-mode-hook 'paredit-mode)

  (add-hook 'nrepl-interaction-mode-hook
            'nrepl-turn-on-eldoc-mode))
