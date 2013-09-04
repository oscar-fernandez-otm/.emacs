(server-start)

(add-hook 'after-init-hook 'after-package-initializations-customizations)

(defun ido-recentf-open ()
  "Use `ido-completing-read' to \\[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))

(defun after-package-initializations-customizations ()
  (load-theme 'zenburn t)

  (global-set-key (kbd "C-.") 'hippie-expand)

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

  ;; auto-complete
  (require 'auto-complete-config)
  (ac-config-default)

  ;; multiple cursors
  (global-set-key (kbd "C-c C-m") 'mc/edit-lines)
  (global-set-key (kbd "C-:") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-;") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-:") 'mc/mark-all-like-this)

  ;; expand region
  (global-set-key (kbd "M-S-<up>") 'er/expand-region)
  (setq expand-region-contract-fast-key "<down>")

  ;; iy-go-to-char
  (global-set-key (kbd "C-c C-f") 'iy-go-to-char)
  (global-set-key (kbd "C-c C-b") 'iy-go-to-char-backward)

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
           ["jx" smex]])
  (key-chord-mode 1))
