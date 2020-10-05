;;; flycheck-dmd-dub-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "flycheck-dmd-dub" "flycheck-dmd-dub.el" (23230
;;;;;;  48279 957860 144000))
;;; Generated autoloads from flycheck-dmd-dub.el

(autoload 'flycheck-dmd-dub-set-variables "flycheck-dmd-dub" "\
Set all flycheck-dmd variables.
It also outputs the values of `import-paths' and `string-import-paths'
to `fldd--cache-file' to reuse the result of dub describe.

\(fn)" t nil)

(autoload 'fldd-run "flycheck-dmd-dub" "\
Set all flycheck-dmd variables.
It also outputs the values of `import-paths' and `string-import-paths'
to `fldd--cache-file' to reuse the result of dub describe.

\(fn)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; flycheck-dmd-dub-autoloads.el ends here
