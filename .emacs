(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(agda2-highlight-face-groups (quote default-faces))
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(inhibit-startup-screen t)
 '(initial-buffer-choice nil)
 '(make-backup-files nil)
 '(scroll-step 1)
 '(menu-bar-mode nil)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "More Perfect DOS VGA" :foundry "unknown" :slant normal :weight normal :height 120 :width normal)))))

(global-set-key (kbd "C-x a r") 'align-regexp)
(global-set-key (kbd "C-x ç") 'shrink-window)
(defun my-comint-init () (setq comint-process-echoes t))
(add-hook 'comint-mode-hook 'my-comint-init)

;; web-mode
;(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
;(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
;(add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode))
;(add-to-list 'auto-mode-alist '("\\.[gj]sp\\'" . web-mode))
;(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
;(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
;(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
;(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

;; package
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

;; auto-complete
(ac-config-default)
;; (require 'ac-math)
;; (add-to-list 'ac-modes 'latex-mode)

;; yasnippet
(require 'yasnippet)
(yas-global-mode t)

;; haskell
(require 'inf-haskell)
;;(load "~/.emacs.d/haskell-mode/haskell-site-file")
;;(load "~/.emacs.d/haskell-mode/inf-haskell")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;;(setq haskell-font-lock-symbols t)
(global-set-key [f1] 'inferior-haskell-start-process)
(global-set-key [f2] (lambda () (interactive) (switch-to-buffer "*haskell*")))
;;(require 'inf-haskell)

;; j
(add-to-list 'load-path "/home/bemkap/.emacs.d/j-mode/")
(setq j-path "/home/bemkap/j804/bin/")
(setq j-command "jconsole")
(autoload 'j-mode "j-mode.el"  "Major mode for J." t)
(autoload 'j-shell "j-mode.el" "Run J from emacs." t)
(setq auto-mode-alist (cons '("\\.ij[rstp]" . j-mode) auto-mode-alist))
(global-set-key [f3] 'j-shell)

;; vbasense
;; (require 'vbasense)
;; (vbasense-config-default)

;; window mode
(require 'window-number)
(window-number-mode 1)

;; color-theme
(require 'color-theme)
(require 'inkpot-theme)
;(color-theme-solarized)
