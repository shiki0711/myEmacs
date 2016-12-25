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
    py-autopep8))

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

;; init.el ends here

