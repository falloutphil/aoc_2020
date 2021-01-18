;;; Minimal setup file for guix emacs.

(load-theme 'zenburn t)
(set-frame-font "Monospace 16")

(windmove-default-keybindings)
(add-hook 'org-shiftup-final-hook 'windmove-up)
(add-hook 'org-shiftleft-final-hook 'windmove-left)
(add-hook 'org-shiftdown-final-hook 'windmove-down)
(add-hook 'org-shiftright-final-hook 'windmove-right)

(global-set-key (kbd "C-x g") 'magit-status)

(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(which-key-mode)
(key-chord-mode 1)

(add-hook 'prog-mode-hook #'flycheck-mode)
(add-hook 'prog-mode-hook #'which-function-mode)
