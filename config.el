;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "chenbing"
      user-mail-address "chenbing999@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

(cond ((display-graphic-p)
       ;; 编辑器字体
       (set-face-attribute 'default nil :font "Sarasa Fixed SC 18")
       (custom-set-faces
        ;; custom-set-faces was added by Custom.
        ;; If you edit it by hand, you could mess it up, so be careful.
        ;; Your init file should contain only one such instance.
        ;; If there is more than one, they won't work right.
        '(default ((t :family "Sarasa Fixed SC" :size 16))))
       (dolist (charset '(kana han cjk-misc bopomofo))
         (set-fontset-font (frame-parameter nil 'font)
                           charset (font-spec :family "Sarasa Fixed SC" :size 18)))
       ))

;; (setq doom-font (font-spec :family "Monaco" :size 16))
;; (setq doom-theme 'doom-gruvbox-light)
(setq doom-theme 'doom-solarized-light)
;; (setq doom-theme 'doom-one)
;; (setq doom-theme 'doom-one-light)
;; (setq doom-theme 'doom-dracula)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

(load! "kbd")

(load! "roam")

;; 最大化窗口
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; python3
(setq python-shell-interpreter "python3"
      flycheck-python-pycompile-executable "python3")

;; 设置默认后端为 `xelatex'
(setq org-latex-compiler "xelatex")
;; pandoc
(setq org-pandoc-options '((standalone . t)
                           (pdf-engine . "xelatex")
                           (number-sections . t)))
(setq org-pandoc-options-for-latex-pdf '((resource-path . "/Users/chenbing/Library/Mobile Documents/com~apple~CloudDocs/images")))
(setq org-pandoc-format-extensions '(markdown_github+pipe_tables+raw_html))
(add-to-list 'image-type-file-name-regexps '("\\.pdf\\'" . imagemagick))
(add-to-list 'image-file-name-extensions "pdf")
(setq imagemagick-types-inhibit (remove 'PDF imagemagick-types-inhibit))
(setq org-image-actual-width t)
;; (setq org-image-actual-width 600)

;; https://www.gnu.org/software/emacs/manual/html_node/org/Advanced-Export-Configuration.html
(defun my-org-export-filter-link (text _ _)
  ;; (message (format "text = %s" text))
  (string-replace "/Users/chenbing/Library/Mobile Documents/com~apple~CloudDocs/images/" "" text)
  )
;; (add-to-list 'org-export-filter-link-functions 'my-org-export-filter-link)

;; plantuml
(setq plantuml-jar-path "~/soft/jar/plantuml.jar")
(setq org-plantuml-jar-path "~/soft/jar/plantuml.jar")
(setq plantuml-default-exec-mode 'jar)
(org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t)))
;; (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
;; helper function
(defun my-org-confirm-babel-evaluate (lang _body)
"Do not ask for confirmation to evaluate code for specified languages."
  (member lang '("plantuml")))
;; trust certain code as being safe
(setq org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)
;; automatically show the resulting image
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images)

;; org bold selected word
(defun bold-region-or-point ()
  (interactive)
  (if (region-active-p)
      (progn
        (goto-char (region-end))
        (insert "* ")
        (goto-char (region-beginning))
        (insert " *"))
    (insert "**")
    (backward-char)))
(define-key global-map (kbd "s-b") 'bold-region-or-point)

(defun bold-region-or-point-without-space ()
  (interactive)
  (if (region-active-p)
      (progn
        (goto-char (region-end))
        (insert "*")
        (goto-char (region-beginning))
        (insert "*"))
    (insert "**")
    (backward-char)))
(define-key global-map (kbd "s-B") 'bold-region-or-point-without-space)

;; proxy
;; 注意：代理地址前面不要加 schema ，比如 http / https
(defun my-proxy-on ()
  (interactive)
  (setq url-using-proxy t)
  (setq url-proxy-services
        '(
          ("no_proxy" . "^\\(localhost\\|10.*\\|172.*\\|192.*\\)")
          ("http" . "127.0.0.1:1087")
          ("https" . "127.0.0.1:1087")
          )))

(defun my-proxy-off ()
  (interactive)
  (setq url-using-proxy nil)
  (setq url-proxy-services nil))

;; 设置tab默认行为
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

;; org 禁用下划线上标
(setq org-export-with-sub-superscripts nil)

;; deft
;; Overwrite `deft-current-files` for the `deft-buffer-setup` and limit it to 30 entries
(defun my-deft-limiting-fn (orig-fun &rest args)
  (let
      ((deft-current-files (-take 200 deft-current-files)))
    (apply orig-fun args)))

(advice-add 'deft-buffer-setup :around #'my-deft-limiting-fn)

(setq deft-directory "~/.deft"
      deft-extensions '("org" "txt")
      deft-recursive t)

(setq deft-use-filename-as-title t)

;; 自动填充折行
(setq-default fill-column 120)
(add-hook 'org-mode-hook 'turn-on-auto-fill)
(add-hook 'markdown-mode-hook 'turn-on-auto-fill)

;; org-bullets
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(setq org-num-max-level 3)
(setq org-superstar-headline-bullets-list '("☯" "☰" "☱" "☲" "☳" "☴" "☵" "☶" "☷"))

;; org-agenda
(setq org-agenda-weekend-days '(5 6))
(setq calendar-weekend-days '(5 6))
(setq org-agenda-files '("~/org-agenda/"))

;; https://www.emacswiki.org/emacs/TruncateLines
(add-hook 'org-mode-hook (lambda() (set 'truncate-lines t)))

;; sqlformat
(setq sqlformat-command 'pgformatter)
(setq sqlformat-args '("-s2" "-g"))

;; 图片缓存时间
(setq image-cache-eviction-delay 28800)

;; super-save 自动保存
;; (use-package super-save
;;   :ensure t
;;   :config
;;   (super-save-mode +1)
;;   (setq super-save-auto-save-when-idle t)
;;   (setq super-save-idle-duration 5))

;; disable company for org
(setq company-global-modes '(not org-mode sh-mode))
(setq company-minimum-prefix-length 3)
(setq company-dabbrev-other-buffers nil)

;; jsx support
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . rjsx-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . rjsx-mode))

;; 自动切换输入法
(defun my/change-input-to-english ()
  (when (not (evil-insert-state-p evil-next-state))
    (message "change input to english")
    (with-temp-buffer
      (shell-command "macism com.apple.keylayout.ABC" t))))
(add-hook 'evil-insert-state-exit-hook 'my/change-input-to-english)
(add-hook 'minibuffer-exit-hook 'my/change-input-to-english)

;; show icon for major mode
(setq doom-modeline-major-mode-icon t)
