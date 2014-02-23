(add-hook 'after-init-hook 'lisp-customizations)

(defun lisp-customizations ()

  (add-to-list 'auto-mode-alist '("\\.clj.\\'" . clojure-mode))

  (define-key lisp-mode-shared-map (kbd "C-,") 'lisp-complete-symbol)

  (require 'ac-nrepl)
  (add-hook 'cider-repl-mode-hook 'ac-nrepl-setup)
  (add-hook 'cider-interaction-mode-hook 'ac-nrepl-setup)
  (eval-after-load "auto-complete"
    '(add-to-list 'ac-modes 'cider-mode))

  (add-hook 'cider-mode-hook
            (lambda ()
              (define-key cider-mode-map (kbd "C-,")
                'complete-symbol)))


  (add-hook 'cider-repl-mode-hook 'paredit-mode)

  (add-hook 'cider-mode-hook
            'cider-turn-on-eldoc-mode))
