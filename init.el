(require 'package)

(add-hook 'after-init-hook 'after-package-initializations-customizations)
(add-hook 'after-init-hook 'lisp-customizations)

(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; Add in your own as you wish:
(defvar my-packages '(starter-kit starter-kit-lisp starter-kit-bindings starter-kit-ruby starter-kit-js zenburn-theme undo-tree cider multiple-cursors expand-region iy-go-to-char key-chord ace-jump-mode multi-term ag company company-flx flx-ido projectile align-cljlet clj-refactor org-trello)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))
(put 'upcase-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (org-trello midje-mode
                (cider . "melpa-stable")
                zenburn-theme undo-tree starter-kit-ruby starter-kit-lisp starter-kit-js starter-kit-bindings projectile multi-term magit-popup key-chord iy-go-to-char git-commit flx-ido expand-region company company-flx clj-refactor align-cljlet ag ace-jump-mode))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
