(defun lisp-customizations ()

  (add-to-list 'auto-mode-alist '("\\.clj.\\'" . clojure-mode))

  (add-hook 'cider-repl-mode-hook 'paredit-mode)

  (add-hook 'cider-mode-hook
            'cider-turn-on-eldoc-mode)
  (require 'clj-refactor)
  (add-hook 'clojure-mode-hook (lambda ()
                                 (define-key clojure-mode-map (kbd "C-c l") 'align-cljlet)
                                 (clj-refactor-mode 1)
                                 (cljr-add-keybindings-with-prefix "C-c j"))))
