;lfdfd;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-tokyo-night)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(require 'package)
(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ;("org-cn". "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/"
                          )))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(require 'bind-key)

;;set env for curl
(setenv "PATH" (concat (getenv "PATH") ":$home/scoop/apps/curl/current/bin/curl.exe"));;replaceable-path
;; (defun set-exec-path-from-shell-PATH () ;

;;   )


;; load module settings
(setq user-emacs-directory "~/.emacs.d/");;replaceable-path
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "lib" user-emacs-directory))


;;Key Configuration for Doom as Vanilla Emacs
(setq evil-default-state 'emacs)

(setq-default buffer-file-coding-system 'utf-8)

(set-fontset-font t nil "Symbola" nil 'prepend)
(set-face-attribute
 'default nil
 :font (font-spec :name "IBM Plex Mono"
                  ;;Iosevka;;cascadia mono;;
                  :Weight 'normal
                  :slant 'normal
                  :size 11.5))
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font
   (frame-parameter nil 'font)
   charset
   (font-spec :name "仓耳今楷02 W04"
   ;(font-spec :name "LXGW WenKai"
              :weight 'normal
              :slant 'normal
              :size
              12.5)))

(defun set-org-mode-font ()
  "Set a specific font for Org-mode buffers."
  (interactive)
  (setq buffer-face-mode-face '(:family "cascadia mono" :height 120)) ; Customize the font family and size
  (buffer-face-mode))

(add-hook 'org-mode-hook 'set-org-mode-font)


;; Enable Cache
(setq url-automatic-caching t)

;; bing-dict
(use-package bing-dict :ensure t)
(global-set-key (kbd "C-c d") 'bing-dict-brief)
(setq bing-dict-vocabulary-file "C:/Users/yuding/iCloudDrive/Documents/emacs-bing_vocabulary.org")
(setq bing-dict-vocabulary-save t)
;;replaceable-path

(defun previous-multilines ()
  "scroll down multiple lines"
  (interactive)
  (scroll-down (/ (window-body-height) 3)))

(defun next-multilines ()
  "scroll up multiple lines"
  (interactive)
  (scroll-up (/ (window-body-height) 3)))

(global-set-key "\M-n" 'next-multilines) ;;custom
(global-set-key "\M-p" 'previous-multilines) ;;custom


(setq auto-save-visited-mode t)
(auto-save-visited-mode +1)


(setq-default buffer-file-coding-system 'utf-8)

(use-package clipetty
  :ensure t
  :bind ("M-w" . clipetty-kill-ring-save))


(global-visual-line-mode t)
(use-package visual-fill-column :ensure t)
(add-hook 'visual-line-mode-hook #'visual-fill-column-mode)
(setq-default visual-fill-column-center-text t)
(setq org-image-actual-width nil)

(defun enable-visual-fill-column-mode ()
  "Enable visual-fill-column-mode in specific buffers."
  (visual-fill-column-mode 1))
(add-hook 'message-mode-hook 'enable-visual-fill-column-mode)
(add-hook 'help-mode-hook 'enable-visual-fill-column-mode)

(add-hook 'after-make-frame-functions 'adjust-fill-column-to-frame-width)
(defun adjust-fill-column-to-frame-width (frame)
  "Adjust the `fill-column` to match the width of the FRAME."
  (with-selected-frame frame
    (setq fill-column (window-width))))
;; Set `fill-column` for the initial frame
(when (display-graphic-p)
  (setq fill-column (window-width)))


(use-package geiser :ensure t)
(setq geiser-active-implementations '(chez guile racket chicken mit chibi gambit))
(setq scheme-program-name "racket")
(setq geiser-scheme-implementation 'racket)
(add-hook 'scheme-mode-hook 'geiser-mode)
(setq geiser-default-implementation 'racket)

(use-package ivy :ensure t)
(ivy-mode 1)

;;key-bindings
(defun select-current-line ()
  "Select the line at the current cursor position."
  (interactive)
  (let ((line-begin (line-beginning-position))
        (line-end (line-end-position)))
    (goto-char line-begin)
    (set-mark line-end)))

(global-set-key (kbd "C-c C-s") 'select-current-line)
