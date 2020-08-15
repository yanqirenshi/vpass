(in-package :vpass.importer)

(defun total-p (line)
  (string/= "" (first line)))
