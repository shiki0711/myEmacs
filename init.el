;; init.el --- Emacs configuration

;; INSTALL PACKAGES
;; --------------------------------------

(require 'package)

;; (add-to-list 'package-archives
;;        '("melpa" . "http://melpa.org/packages/") t)
  
;; (setq package-archives '(("melpa" . "http://melpa.milkbox.net/packages/")
;; 			 ("gnu" . "http://elpa.gnu.org/packages/")))

(setq package-archives  
       '(("gnu"          . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/") 
         ("melpa"        . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/") 
         ("melpa-stable" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa-stable/") 
         ("org"          . "https://mirrors.tuna.tsinghua.edu.cn/elpa/org/") 
         ("marmalade"    . "https://mirrors.tuna.tsinghua.edu.cn/elpa/marmalade/")))

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    ein
    elpy
    flycheck
    material-theme
    py-autopep8
    ;;; ycmd
    deferred
    request-deferred
    s
    dash
    let-alist
    f
    company
    company-ycmd
    flycheck-ycmd
    cl-lib
    ycmd))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;; BASIC CUSTOMIZATION
;; --------------------------------------

(setq inhibit-startup-message t) ;; hide the startup message
(load-theme 'material t) ;; load material theme
(global-linum-mode t) ;; enable line numbers globally

;; PYTHON CONFIGURATION
;; --------------------------------------

(elpy-enable)
(elpy-use-ipython)

;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; enable autopep8 formatting on save
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; Not surpported IPython 5's new prompt behavior.
(setenv "IPY_TEST_SIMPLE_PROMPT" "1")


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (py-autopep8 material-theme flycheck elpy ein better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; ----------------
;;; ycmd config
;;; ----------------

;;(add-to-list 'load-path "~/.emacs.d/emacs-ycmd/")
(require 'company)
(add-hook 'c++-mode-hook 'company-mode)

;;; To use ycmd-mode in cpp mode
(require 'ycmd)
(add-hook 'c++-mode-hook 'ycmd-mode)

;;; specify how to run the server
(set-variable 'ycmd-server-command '("python" "/home/yanfeng/.emacs.d/ycmd/ycmd"))
;;; (set-variable 'ycmd-global-config "/home/yanfeng/.emacs.d/ycm_global_config.py")

;;; company-ycmd
(require 'company-ycmd)
(company-ycmd-setup)


;;; flycheck integration
(require 'flycheck-ycmd)
(flycheck-ycmd-setup)

;;; Disabling ycmd-based flycheck for python mode
(add-hook 'python-mode-hook (lambda () (add-to-list 'flycheck-disabled-checkers 'ycmd)))

;;; Making flycheck and company work together
(when (not (display-graphic-p))
  (setq flycheck-indication-mode nil))

;;; eldoc integration
(require 'ycmd-eldoc)
(add-hook 'ycmd-mode-hook 'ycmd-eldoc-setup)

;; init.el ends here
