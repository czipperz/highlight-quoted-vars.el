;;; init-shell-highlighting.el --- Highlights variables preceded by `$' and not a `\'.

;; Copyright (C) 2015 Free Software Foundation, Inc.

;; Author: Lindydancer
;; Maintainer: Lindydancer
;;     Czipperz
;; URL: https://github.com/czipperz/highlight-quoted-vars.el
;; Version: 0.1
;; Keywords: faces

;; This file is NOT part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.


;;; Commentary:
;;
;; This program allows you to easily recognize when a variable is
;; being interpolated in Strings without having to guess.
;;
;; For example:
;;     "$HOME will be highlighted while \$notHighlighted will not be"
;;     'Any $Vars will NOT be highlighted in $single quotes'
;;
;; To use this software, add a variation of the following code to one
;; of your init files (`$HOME/.emacs.d/init.l', or `$HOME/.emacs'):
;;     (add-hook 'sh-mode-hook 'sh-script-extra-font-lock-activate)

;;; Code:
(defun sh-script-extra-font-lock-match-var-in-double-quoted-string (limit)
  "Search for variables in double-quoted strings.
LIMIT is the place at which the search will end."
  (let (res)
    (while
        (and (setq res (progn (if (eq (get-byte) ?$) (backward-char))
                              (re-search-forward
                               "[^\\]\\$\\({#?\\)?\\([[:alpha:]_][[:alnum:]_]*\\|[-#?@!]\\|[[:digit:]]+\\)"
                               limit t)))
             (not (eq (nth 3 (syntax-ppss)) ?\")))) res))

(defvar sh-script-extra-font-lock-keywords
  '((sh-script-extra-font-lock-match-var-in-double-quoted-string
     (2 font-lock-variable-name-face prepend))))

(defun sh-script-extra-font-lock-activate ()
  "Activates highlighting of interpolation in double quoted strings.
Usage:
    (add-hook 'sh-mode-hook 'sh-script-extra-font-lock-activate)"
  (interactive)
  (font-lock-add-keywords nil sh-script-extra-font-lock-keywords)
  (if (fboundp 'font-lock-flush)
      (font-lock-flush)
    (when font-lock-mode (with-no-warnings (font-lock-fontify-buffer)))))

(add-hook 'sh-mode-hook     'sh-script-extra-font-lock-activate)
(add-hook 'perl-mode-hook   'sh-script-extra-font-lock-activate)
(add-hook 'python-mode-hook 'sh-script-extra-font-lock-activate)

(provide 'init-shell-highlighting)
;;; highlight-quoted-vars ends here
