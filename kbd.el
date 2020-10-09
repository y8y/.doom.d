;;; ~/.doom.d/kbd.el -*- lexical-binding: t; -*-

(after! evil (map! :v "v"   (general-predicate-dispatch 'er/expand-region
                              (eq (evil-visual-type) 'line)
                              'evil-visual-char)
                   :v "C-v" #'er/contract-region
                   :n "f" #'avy-goto-word-1)
  )
