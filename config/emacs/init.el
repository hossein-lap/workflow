(setq inhibit-startup-message t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room

(menu-bar-mode -1)            ; Disable the menu bar

;; Set up the visible bell
(setq visible-bell nil)

;(set-face-attribute 'default nil :font "Vazir Code Hack Extra Height" :height 220)
;(setq default-frame-alist '((font . "Fira Code 20")))
(setq default-frame-alist '((font . "Vazir Code Hack Extra Height 15")))
(setq scroll-step 1) ;; keyboard scroll one line at a time
(load-theme 'wombat)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Initialize package sources
;(require 'package)

;(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ;("org" . "https://orgmode.org/elpa/")
                         ;("elpa" . "https://elpa.gnu.org/packages/")))

;(package-initialize)
;(unless package-archive-contents
 ;(package-refresh-contents))

;; Initialize use-package on non-Linux platforms
;(unless (package-installed-p 'use-package)
   ;(package-install 'use-package))

;(require 'use-package)
;(setq use-package-always-ensure t)

;; Initialize package sources
;(require 'package)
;
;(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ;("org" . "https://orgmode.org/elpa/")
                         ;("elpa" . "https://elpa.gnu.org/packages/")))
;
;(package-initialize)
;(unless package-archive-contents
   ;(package-refresh-contents))
;
;;; Initialize use-package on non-Linux platforms
;;(unless (package-installed-p 'use-package)
   ;;(package-install 'use-package))
;
;(use-package command-log-mode)
;
;(use-package ivy
;  :diminish
;  :bind (("C-s" . swiper)
;         :map ivy-minibuffer-map
;         ("TAB" . ivy-alt-done)	
;         ("C-l" . ivy-alt-done)
;         ("C-j" . ivy-next-line)
;         ("C-k" . ivy-previous-line)
;         :map ivy-switch-buffer-map
;         ("C-k" . ivy-previous-line)
;         ("C-l" . ivy-done)
;         ("C-d" . ivy-switch-buffer-kill)
;         :map ivy-reverse-i-search-map
;         ("C-k" . ivy-previous-line)
;         ("C-d" . ivy-reverse-i-search-kill))
;  :config
;  (ivy-mode 1))
;
;(use-package doom-modeline
;  :ensure t
;  :init (doom-modeline-mode 1)
;  :custom ((doom-modeline-height 15)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ignored-local-variable-values '((git-commit-major-mode . git-commit-elisp-text-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;;; scroll
(setq pixel-scroll-precision-large-scroll-height 40.0)
;; scroll one line at a time (less "jumpy" than defaults)    
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time    
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

;; Swtich alt and super key
(setq x-meta-keysym 'super)
(setq x-super-keysym 'meta)

;; Evil-Mode
;(add-to-list 'package-archives
;             (cons "nongnu" (format "http%s://elpa.nongnu.org/nongnu/"
;                                    (if (gnutls-available-p) "s" ""))))
(add-to-list 'load-path "/home/hos/.config/emacs/evil")
(require 'evil)
(evil-mode 1)

(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))
