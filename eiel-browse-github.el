;;; eiel-browse-github.el --- browe current point in github  -*- lexical-binding: t; -*-

;; Copyright (C) HIMURA Tomohiko

;; Author: HIMURA Tomohiko <eiel.hal@gmail.com>

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2 of
;; the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be
;; useful, but WITHOUT ANY WARRANTY; without even the implied
;; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
;; PURPOSE.  See the GNU General Public License for more details.

;; You should have received a copy of the GNU General Public
;; License along with this program; if not, write to the Free
;; Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
;; MA 02111-1307 USA

;;; Commentary:
;; 

;;; Code:

(defvar eiel-browse-github-open-command "open" "Browse open command.")
(region-active-p)

;;;###autoload
(defun eiel-browse-github ()
  "Browse source code in github."
  (interactive)
  (let* ((file-name (buffer-file-name (current-buffer)))
	 (start-line (if (region-active-p)
			 (line-number-at-pos (region-beginning))
		       (line-number-at-pos)
		       ))
	 (end-line (and (region-active-p)
			(line-number-at-pos (region-end))))
	 (url (eiel-browse-github-to-url file-name start-line end-line)))
    (eiel-browse-github--browse-url url)
    ))

;;;###autoload
(defun eiel-browse-github-to-url (file-path &optional start-line end-line)
  "Translate github url from file path.
Argument FILE-PATH"
  (let*
      ((paths (eiel-browse-github--seprate-source-paths file-path))
       (root-path (car paths))
       (source-path (replace-regexp-in-string ".gz" "" (cdr paths)))
       (branch (eiel-browse-github--branch-name-for-emacs root-path))
       (hash-param (cond
		    ((null start-line) "")
		    ((or (null end-line)
			 (equal start-line end-line))
		     (format "#L%s" start-line))
		    (t (format "#L%s-L%s" start-line end-line))
		    ))
       )
    (format "https://github.com/emacs-mirror/emacs/blob/%s/%s%s" branch source-path hash-param)
    ))

(defun eiel-browse-github--browse-url (url)
  "Open URL in Browse."
  (shell-command (format "%s %s" eiel-browse-github-open-command url))
  )

(defun eiel-browse-github--branch-name-for-emacs (path)
  "Get branch name from PATH."
  (let*
      ((path-length (length path))
       (version (substring path (- path-length 4) path-length)))
    (format "emacs-%s" version)))

(defun eiel-browse-github--seprate-source-paths (file-path)
  "Search source root path from FILE-PATH."
  (string-match "\\(.*/share/[^/]*/[^/]*\\)/\\(.*\\)" file-path)
  (cons (match-string 1 file-path)
	(match-string 2 file-path)))

(provide 'eiel-browse-github)

;;; eiel-browse-github.el ends here
