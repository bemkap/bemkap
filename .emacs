(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(custom-enabled-themes (quote (sanityinc-tomorrow-night)))
 '(custom-safe-themes
   (quote
    ("06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default)))
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(initial-buffer-choice nil)
 '(make-backup-files nil)
 '(menu-bar-mode nil)
 '(package-selected-packages
   (quote
    (ample-theme helm-company company company-c-headers company-math helm color-theme-sanityinc-tomorrow yasnippet window-number web-mode stem solarized-theme pretty-symbols popwin pabbrev magit lua-mode inkpot-theme glsl-mode flycheck-dmd-dub d-mode auto-complete-c-headers auctex ac-haskell-process)))
 '(scroll-step 1)
 '(tool-bar-mode nil)
 '(visible-cursor nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(global-set-key (kbd "C-x a r") 'align-regexp)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x C-,") 'comment-line)

;; package
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))
(package-initialize)

;; company
(add-hook 'after-init-hook 'global-company-mode)

;; yasnippet
(yas-global-mode 1)

;; haskell-mode
(require 'inf-haskell)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(global-set-key [f1] 'inferior-haskell-start-process)
(global-set-key [f2] (lambda () (interactive) (switch-to-buffer "*haskell*")))

;; j-mode
(add-to-list 'load-path "/home/bemkap/.emacs.d/j-mode/")
(autoload 'j-mode "j-mode.el" "Major mode for editing J files" t)
(add-to-list 'auto-mode-alist '("\\.ij[rstp]$" . j-mode))
(require 'j-console)
(global-set-key [f5] 'j-console)

;; prolog
;; (add-to-list 'auto-mode-alist '("\\.P$" . prolog-mode))

;; java
(add-hook 'java-mode-hook (lambda () (setq c-basic-offset 2)))

;; window mode
(require 'window-number)
(window-number-mode 1)

;; color-theme
;; (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;; (require 'color-theme)
;; (require 'inkpot-theme)
;; (color-theme-sanityinc-tomorrow-night)
(ample-theme)

(mapc
 (lambda (face) (set-face-attribute face nil :weight 'normal :underline nil))
 (face-list))

;; (setq debug-on-error t)

;; (load-file (let ((coding-system-for-read 'utf-8))
;;                 (shell-command-to-string "agda-mode locate")))

(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
