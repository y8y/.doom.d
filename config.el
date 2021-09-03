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
;; (setq doom-theme 'doom-gruvbox)
;; (setq doom-theme 'doom-monokai-pro)
(setq doom-theme 'doom-one)

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

;; 最大化窗口
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; svg viewer for org-roam
;; (after! org-roam
;;   (setq org-roam-graph-viewer "/usr/bin/open"))

;; org-roam-server
;; (use-package org-roam-server)

;; python3
(setq python-shell-interpreter "python3"
      flycheck-python-pycompile-executable "python3")

;; 使用xelatex一步生成PDF，不是org-latex-to-pdf-process这个命令
(setq org-latex-pdf-process
      '(
        "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "rm -fr %b.out %b.log %b.tex auto"
        ))
;; 设置默认后端为 `xelatex'
(setq org-latex-compiler "xelatex")

;; plantuml
(setq plantuml-jar-path "~/soft/jar/plantuml.jar")
(setq org-plantuml-jar-path "~/soft/jar/plantuml.jar")
(setq plantuml-default-exec-mode 'jar)
(org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t)))
(add-to-list 'org-src-lang-modes '("plantuml" . plantuml))

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

;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(custom-safe-themes
;;    '("e2acbf379aa541e07373395b977a99c878c30f20c3761aac23e9223345526bcc" "0cb1b0ea66b145ad9b9e34c850ea8e842c4c4c83abe04e37455a1ef4cc5b8791" "be9645aaa8c11f76a10bcf36aaf83f54f4587ced1b9b679b55639c87404e2499" default))
;;  '(package-selected-packages '(org-roam-server)))

;; 设置tab默认行为
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

;; emacs smart input source
;; (use-package sis
;;   ;; :hook
;;   ;; enable the /follow context/ and /inline region/ mode for specific buffers
;;   ;; (((text-mode prog-mode) . sis-follow-context-mode)
;;   ;;  ((text-mode prog-mode) . sis-inline-mode))

;;   :config
;;   (sis-ism-lazyman-config
;;    "com.apple.keylayout.ABC"
;;    ;; "com.apple.keylayout.US"
;;    ;; "im.rime.inputmethod.Squirrel.Rime"
;;    "com.sogou.inputmethod.sogou.pinyin"
;;    ;; "com.apple.inputmethod.SCIM.ITABC"
;;    )

;;   ;; enable the /cursor color/ mode
;;   ;; 光标颜色指示
;;   ;; 1. 绿色：中文
;;   ;; 2. 白色：英文
;;   (sis-global-cursor-color-mode t)
;;   ;; enable the /respect/ mode
;;   (sis-global-respect-mode t)
;;   ;; enable the /follow context/ mode for all buffers
;;   (sis-global-context-mode t)
;;   ;; enable the /inline english/ mode for all buffers
;;   (sis-global-inline-mode t)
;;   )

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
      deft-extensions '("org" "txt" "md")
      deft-recursive t)

(setq deft-use-filename-as-title t)

;; 自动填充折行
(setq-default fill-column 120)
(add-hook 'org-mode-hook 'turn-on-auto-fill)
(add-hook 'markdown-mode-hook 'turn-on-auto-fill)

;; org-bullets
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(setq org-num-max-level 3)

;; org-agenda
(setq org-agenda-weekend-days '(5 6))
(setq calendar-weekend-days '(5 6))

;; sqlformat
(setq sqlformat-command 'pgformatter)
(setq sqlformat-args '("-s2" "-g"))

;; 图片缓存时间
(setq image-cache-eviction-delay 28800)

;; super-save 自动保存
(use-package super-save
  :ensure t
  :config
  (super-save-mode +1)
  (setq super-save-auto-save-when-idle t)
  (setq super-save-idle-duration 5))

;; disable company for org
;; (setq company-global-modes '(not org-mode sh-mode))
(setq company-global-modes '(not sh-mode))
(setq company-minimum-prefix-length 3)

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

;; title bar 优化
;; (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
;; (add-to-list 'default-frame-alist '(ns-appearance . dark))
;; (setq ns-use-proxy-icon nil)
;; (setq-default frame-title-format
;;               '(:eval
;;                 (format "%s"
;;                         (cond
;;                          (buffer-file-truename
;;                           (concat "(" buffer-file-truename ")"))
;;                          (dired-directory
;;                           (concat "{" dired-directory "}"))
;;                          (t
;;                           "[no file]")))))

;; 解决 modeline CPU 高负载
;; 参考：https://github.com/seagle0128/doom-modeline/issues/32
;; (setq doom-modeline-buffer-file-name-style 'file-name)
