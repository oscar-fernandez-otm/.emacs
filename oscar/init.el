(server-start)

(add-hook 'after-init-hook 'after-package-initializations-customizations)

(defun ido-recentf-open ()
  "Use `ido-completing-read' to \\[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))


(defun last-term-buffer (l)
  "Return most recently used term buffer."
  (when l
    (if (eq 'term-mode (with-current-buffer (car l) major-mode))
        (car l)
      (last-term-buffer (cdr l)))))

(defun get-term (arg)
  "Switch to the term buffer last used in another window, or create a new one if none exists, or if the current buffer is already a term.
If you want to switch in the same window pass a prefix argument."
  (interactive "P")
  (let ((b (last-term-buffer (buffer-list))))
    (if (or (not b) (eq 'term-mode major-mode))
        (multi-term)
      (if arg
          (switch-to-buffer b)
        (switch-to-buffer-other-window b)))))

(defun after-package-initializations-customizations ()
  (require 'iso-transl)
  (require 'key-chord)
  (load-theme 'zenburn t)

  ;; disable flyspellmode by default for some modes
  (dolist (hook '(nxml-mode-hook))
      (add-hook hook (lambda () (flyspell-mode -1))))

  (global-set-key (kbd "C-.") 'hippie-expand)

  (electric-pair-mode +1)

  (projectile-global-mode)

  ;; paredit
  (require 'paredit)
  (define-key paredit-mode-map (kbd "C-S-<left>") 'paredit-backward-slurp-sexp)
  (define-key paredit-mode-map (kbd "C-S-<right>") 'paredit-backward-barf-sexp)

  ;; undo-tree-mode
  (global-undo-tree-mode)
  (global-set-key (kbd "C--") 'undo-tree-undo)

  ;; eclipse like jump of line in the middle of it
  (global-set-key (kbd "C-<return>") (kbd "C-e C-j"))
  (global-set-key (kbd "C-S-<return>") (kbd "C-a <return> C-p"))


  ;; recentf mode
  (recentf-mode t)
  ; 50 files ought to be enough.
  (setq recentf-max-saved-items 50)

  (global-set-key (kbd "C-x f") 'ido-recentf-open)

  ;; use company mode for autocompletion
  (global-company-mode)
  (global-set-key (kbd "C-,") 'company-complete)

  ;; multiple cursors
  (global-set-key (kbd "C-c C-m") 'mc/edit-lines)
  (global-set-key (kbd "C-;") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-:") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-;") 'mc/mark-all-like-this)

  ;; expand region
  (global-set-key (kbd "M-S-<up>") 'er/expand-region)
  (global-set-key (kbd "M-S-<down>") 'er/contract-region)

  ;; iy-go-to-char
  (global-set-key (kbd "C-c C-f") 'iy-go-to-char)
  (global-set-key (kbd "C-c C-b") 'iy-go-to-char-backward)

  ;; multiterm-configuration
  (setq multi-term-program "/bin/bash")
  (setq multi-term-dedicated-select-after-open-p t)
  (setq multi-term-dedicated-skip-other-window-p t)
  (global-set-key (kbd "C-c t") 'get-term)
  (global-set-key (kbd "C-c d") (lambda ()
                                  (interactive)
                                  (require 'multi-term)
                                  (multi-term-dedicated-toggle)))

  ;; ag configuration
  (global-set-key (kbd "C-c a r") 'ag-regexp)
  (global-set-key (kbd "C-c a p") 'ag-project-regexp)
  

  ;; chords
  (mapcar (lambda (chord)
            (key-chord-define-global (elt chord 0)
                                     (elt chord 1)))
          [["fj" iy-go-to-char]
           ["fh" iy-go-to-char-backward]
           ["fk" ace-jump-mode]
           ["jw" mark-word]
           ["jz" repeat]
           ["df" backward-word]
           ["fg" forward-word]
           ["hj" backward-char]
           ["jk" forward-char]
           ["kd" kill-word]
           ["cv" back-to-indentation]
           ["vb" move-end-of-line]
           ["kw" kill-ring-save]
           ["f," ido-switch-buffer-other-window]
           ["f." ido-switch-buffer]
           ["jr" query-replace-regexp]
           ["jx" smex]
           ["jq" join-line]])
  (key-chord-mode 1))
