(add-hook 'after-init-hook 'lisp-customizations)

(defun lisp-customizations ()

  (add-to-list 'auto-mode-alist '("\\.clj.\\'" . clojure-mode))

  (add-hook 'cider-repl-mode-hook 'paredit-mode)

  (add-hook 'cider-mode-hook
            'cider-turn-on-eldoc-mode))
