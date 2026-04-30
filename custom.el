;;; -*- lexical-binding: t -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(display-buffer-alist
   '(((major-mode . occur-mode) display-buffer-in-side-window
      (side . right) (slot . -1) (window-width . 60))
     ((or (major-mode . ag-mode) (major-mode . grep-mode))
      display-buffer-in-side-window (side . right) (slot . 0)
      (window-width . 60))
     ((major-mode . cider-repl-mode) display-buffer-in-side-window
      (side . right) (slot . 1) (window-width . 60))))
 '(window-sides-slots '(nil nil 3 nil)) 
 
 '(warning-suppress-types '((use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
