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

;; 编辑器字体
(set-face-attribute 'default nil :font "Sarasa Fixed SC 16")
(custom-set-faces
 '(default ((t :family "Sarasa Fixed SC" :size 16))))
(dolist (charset '(kana han cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
                    charset (font-spec :family "Sarasa Fixed SC" :size 16)))

;; (setq doom-font (font-spec :family "Monaco" :size 16))
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
;; 本地代理
(setq url-proxy-services
      '(("no_proxy" . "^\\(localhost\\|127.0.0.1\\|10\\..*\\|192\\.168\\..*\\)")
        ("http" . "127.0.0.1:1087")
        ("https" . "127.0.0.1:1087")))

;; 最大化窗口
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; svg viewer for org-roam
(after! org-roam
  (setq org-roam-graph-viewer "/usr/bin/open"))

;; org-roam-server
(use-package org-roam-server
  :ensure t)

;; python3
(setq python-shell-interpreter "python3"
      flycheck-python-pycompile-executable "python3")

;; pyim
(use-package pyim
  :ensure t
  :demand t
  :config
  ;; 激活 basedict 拼音词库，五笔用户请继续阅读 README
  (use-package pyim-basedict
    :ensure nil
    :config (pyim-basedict-enable))

  (setq default-input-method "pyim")

  ;; 我使用全拼
  (setq pyim-default-scheme 'quanpin)

  ;; 设置 pyim 探针设置，这是 pyim 高级功能设置，可以实现 *无痛* 中英文切换 :-)
  ;; 我自己使用的中英文动态切换规则是：
  ;; 1. 光标只有在注释里面时，才可以输入中文。
  ;; 2. 光标前是汉字字符时，才能输入中文。
  ;; 3. 使用 M-j 快捷键，强制将光标前的拼音字符串转换为中文。
  (setq-default pyim-english-input-switch-functions
                '(pyim-probe-dynamic-english
                  pyim-probe-isearch-mode
                  pyim-probe-program-mode
                  pyim-probe-org-structure-template))

  (setq-default pyim-punctuation-half-width-functions
                '(pyim-probe-punctuation-line-beginning
                  pyim-probe-punctuation-after-punctuation))

  ;; 开启拼音搜索功能
  (pyim-isearch-mode 1)

  ;; 使用 popup-el 来绘制选词框, 如果用 emacs26, 建议设置
  ;; 为 'posframe, 速度很快并且菜单不会变形，不过需要用户
  ;; 手动安装 posframe 包。
  (setq pyim-page-tooltip 'posframe)

  ;; 选词框显示5个候选词
  (setq pyim-page-length 5)

  :bind
  (("M-j" . pyim-convert-string-at-point) ;与 pyim-probe-dynamic-english 配合
   ("C-;" . pyim-delete-word-from-personal-buffer)))

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
