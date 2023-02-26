;;; browse-github.el --- browe current point in github  -*- lexical-binding: t; -*-


;;; Commentary:
;; 

;;; Code:

(defun browse-github ()
  "Browse github."
  (interactive)
  (let*
      ((buffer (current-buffer))
       (file-name (buffer-file-name buffer))
       (line (line-number-at-pos))
       (url (browse-github-to-url file-name line line)))
      (shell-command (format "open %s" url))))

(defun browse-github-to-url (file-path start-line end-line)
  "Translate github url from file path.
Argument FILEP-PATH.
Argument FILE-PATH"
  (let*
      ((paths (browse-github-seprate-source-paths file-path))
       (root-path (car paths))
       (source-path (string-replace ".gz" "" (cdr paths)))
       (branch (browse-github-branch-name-for-emacs root-path)))
    (format "https://github.com/emacs-mirror/emacs/blob/%s/%s#L%s-L%s" branch source-path start-line end-line)))

(defun browse-github-branch-name-for-emacs (path)
  "Get branch name from PATH."
  (let*
      ((path-length (length path))
       (version (substring path (- path-length 4) path-length)))
    (format "emacs-%s" version)))

(defun browse-github-seprate-source-paths (file-path)
  "Search source root path from FILE-PATH."
  (string-match "\\(/.*/share/[^/]*/[^/]*\\)/\\(.*\\)" file-path)
  (cons (match-string 1 file-path)
	(match-string 2 file-path)))


(provide 'browse-github)

;;; browse-github.el ends here
