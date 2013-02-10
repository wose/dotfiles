(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)


(require 'flymake)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("96365813d5be3922a407ac14cb2668cec7d594f8bdd684b614e8db1a14423482" default)))
 '(custom-theme-directory "~/.emacs.d/themes/")
 '(flymake-allowed-file-name-masks (quote (("\\.cc\\'" flymake-simple-make-init) ("\\.cpp\\'" flymake-simple-make-init))))
 '(fringe-mode (quote (nil . 0)) nil (fringe))
 '(menu-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil))

(load-theme 'zunder t)

(add-hook 'find-file-hook 'flymake-find-file-hook)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Source Code Pro" :foundry "adobe" :slant normal :weight normal :height 79 :width normal))))
 '(hl-line ((t (:background "#202020")))))

(require 'cl)
(require 'color)

(defvar heartbeat-fps 20)
(defvar heartbeat-period 2)

(defun heartbeat-range (from to cnt)
  (let ((step (/ (- to from) (float cnt))))
    (loop for i below cnt collect (+ from (* step i)))))

(defun heartbeat-cursor-colors ()
  (let ((cnt (* heartbeat-period heartbeat-fps)))
    (mapcar (lambda (r)
              (color-rgb-to-hex r 0 0))
            (nconc (heartbeat-range .2 1 (/ cnt 2))
                   (heartbeat-range 1 .2 (/ cnt 2))))))

(defvar heartbeat-cursor-timer)
(defvar heartbeat-cursor-old-color)

 (setq heartbeat-cursor-old-color (face-background 'cursor)
          heartbeat-cursor-timer
          (run-with-timer
           0 (/ 1 (float heartbeat-fps))
           (lexical-let ((colors (heartbeat-cursor-colors)) tail)
             (lambda ()
               (setq tail (or (cdr tail) colors))
               (set-face-background 'cursor (car tail))))))


;; ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

(setq ibuffer-expert t)
(setq ibuffer-show-empty-filter-groups nil)

(setq ibuffer-saved-filter-groups
      '(("home"
	 ("emacs-config" (or (filename . ".emacs.d")
			     (filename . "emacs-config")))
	 ("Org" (or (mode . org-mode)
		    (filename . "OrgMode")))
         ("code" (filename . "code"))
	 ("Web Dev" (or (mode . html-mode)
			(mode . css-mode)))
	 ("Magit" (name . "\*magit"))
	 ("Help" (or (name . "\*Help\*")
		     (name . "\*Apropos\*")
		     (name . "\*info\*"))))))

(add-hook 'ibuffer-mode-hook 
	  '(lambda ()
	     (ibuffer-switch-to-saved-filter-groups "home")))
