;;; browse-github-tests --- browe github that current line tests  -*- lexical-binding: t; -*-
(require 'ert)
(require 'browse-github)

;;; Code:

(let (
      (eval.c-in-nix-store-emacs-28.2 "/nix/store/0nindsa0whwpa7ikgixphjc11wixkg6l-emacs-28.2/share/emacs/28.2/src/eval.c")
      (replace-in-nix-store-emacs-28.2 "/nix/store/0nindsa0whwpa7ikgixphjc11wixkg6l-emacs-28.2/share/emacs/28.2/lisp/replace.el.gz")
      (eval.c-in-nix-store-emacs-28.1 "/nix/store/0nindsa0whwpa7ikgixphjc11wixkg6l-emacs-28.1/share/emacs/28.1/src/eval.c"))
  (ert-deftest browse-github-seprate-source-path ()
    ""
    (should
     (equal
      (browse-github-seprate-source-path eval.c-in-nix-store-emacs-28.2)
      '("/nix/store/0nindsa0whwpa7ikgixphjc11wixkg6l-emacs-28.2/share/emacs/28.2" . "src/eval.c")))
    (should
     (equal
      (browse-github-seprate-source-path eval.c-in-nix-store-emacs-28.1)
      '("/nix/store/0nindsa0whwpa7ikgixphjc11wixkg6l-emacs-28.1/share/emacs/28.1" . "src/eval.c"))))

  (ert-deftest github-url ()
    "Test emacs source in nix store to github url."
    (should
     (equal
      (browse-github-to-url eval.c-in-nix-store-emacs-28.2 1727 1749)
      "https://github.com/emacs-mirror/emacs/blob/emacs-28.2/src/eval.c#L1727-L1749"))
    (should
     (equal
      (browse-github-to-url eval.c-in-nix-store-emacs-28.1 1727 1749)
      "https://github.com/emacs-mirror/emacs/blob/emacs-28.1/src/eval.c#L1727-L1749"))
        (should
     (equal
      (browse-github-to-url replace-in-nix-store-emacs-28.2 1727 1749)
      "https://github.com/emacs-mirror/emacs/blob/emacs-28.2/lisp/replace.el#L1727-L1749"))))

;; Local Variables:
;; flycheck-emacs-lisp-load-path: "."
;; End:

(provide 'broswe-github-tests)

;;; broswe-github-tests.el ends here
