(add-hook 'after-init-hook 'lisp-customizations)

(defun custom/jump-to-namespace(regexp)
  (interactive (list (format "\\(ns.*%s$" (read-from-minibuffer "Jump to namespace: "))))
  (let ((b (ag-project-regexp regexp))
        (i 0))
    (switch-to-buffer b)
    (beginning-of-buffer)
    (while (and (not (search-forward "Ag finished" nil t))
                (< i 1000))
      (setq i (+ i 1))
      (sit-for 0.01))
    (beginning-of-buffer)
    (compilation-next-error 1)
    (compile-goto-error)
    (kill-buffer b)))

(defun lisp-customizations ()

  (add-to-list 'auto-mode-alist '("\\.clj.\\'" . clojure-mode))

  (add-hook 'cider-repl-mode-hook 'paredit-mode)

  (add-hook 'cider-mode-hook
            'cider-turn-on-eldoc-mode)
  
  (global-set-key (kbd "C-c j") 'custom/jump-to-namespace))
