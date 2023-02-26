;;; eiel-browse-github-tests.el --- browe github that current line tests  -*- lexical-binding: t; -*-

;; Copyright (C) HIMURA Tomohiko

;; Author: HIMURA Tomohiko <eiel@gmail.com>

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

(require 'ert)
(require 'eiel-browse-github)

;;; Code:

(ert-deftest test-nix-store-emacs-c-source ()
  (let
      ((file-path "/nix/store/0nindsa0whwpa7ikgixphjc11wixkg6l-emacs-28.2/share/emacs/28.2/src/eval.c"))
    (should
     (equal
      (eiel-browse-github--seprate-source-paths file-path)
      '("/nix/store/0nindsa0whwpa7ikgixphjc11wixkg6l-emacs-28.2/share/emacs/28.2" . "src/eval.c")))
    (should
     (equal
      (eiel-browse-github-to-url file-path)
      "https://github.com/emacs-mirror/emacs/blob/emacs-28.2/src/eval.c"))
    (should
     (equal
      (eiel-browse-github-to-url file-path 1)
      "https://github.com/emacs-mirror/emacs/blob/emacs-28.2/src/eval.c#L1"))
    (should
     (equal
      (eiel-browse-github-to-url file-path 1 2)
      "https://github.com/emacs-mirror/emacs/blob/emacs-28.2/src/eval.c#L1-L2"))
    ))

(ert-deftest test-emacs-lisp-source ()
  (let
      ((file-path "/share/emacs/28.2/lisp/replace.el.gz"))
    (should
     (equal
      (eiel-browse-github--seprate-source-paths file-path)
      '("/share/emacs/28.2" . "lisp/replace.el.gz")))
    (should
     (equal
      (eiel-browse-github-to-url file-path)
      "https://github.com/emacs-mirror/emacs/blob/emacs-28.2/lisp/replace.el"))
  ))

(ert-deftest test-emacs-28.1-c-source ()
  (let
      ((file-path "/share/emacs/28.1/src/eval.c"))
    (should
     (equal
      (eiel-browse-github--seprate-source-paths file-path)
      '("/share/emacs/28.1" . "src/eval.c")))
    (should
     (equal
      (eiel-browse-github-to-url file-path)
      "https://github.com/emacs-mirror/emacs/blob/emacs-28.1/src/eval.c"))
    ))

;; Local Variables:
;; flycheck-emacs-lisp-load-path: "."
;; End:

(provide 'broswe-github-tests)

;;; broswe-github-tests.el ends here
