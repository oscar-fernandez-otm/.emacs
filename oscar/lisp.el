(defun lisp-customizations ()
  (add-hook 'cider-repl-mode-hook 'paredit-mode)

  (require 'clj-refactor)
  (add-hook 'clojure-mode-hook (lambda ()
                                 (define-key clojure-mode-map (kbd "C-c l") 'align-cljlet)
                                 (clj-refactor-mode 1)
                                 (cljr-add-keybindings-with-prefix "C-c j"))))
