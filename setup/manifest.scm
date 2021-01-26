;; Install a guix profile for guile dev environment
;; guix package -m manifest.scm -p ~/guix/profiles/aoc
(specifications->manifest
 '("emacs" "emacs-guix" "emacs-geiser" "emacs-paredit" "emacs-magit" "emacs-zenburn-theme" "emacs-smex" "emacs-flx" "emacs-key-chord" "emacs-which-key" "emacs-flycheck-guile"
   "git" "guile"))
