(in-package :vpass.importer)


(defun line2object (line &key account-from)
  (cond ((line-account-p line) (line2account line))
        ((line-trade-p line)   (line2trade line account-from))
        ((total-p line) nil)
        (t nil)))


(defun import-csv-core (lines &key account-from)
  (when-let ((line (car lines)))
    (let ((obj (line2object line :account-from account-from)))
      (cond ((null obj)      (import-csv-core (cdr lines) :account-from account-from))
            ((account-p obj) (import-csv-core (cdr lines) :account-from obj))
            (t (cons obj
                     (import-csv-core (cdr lines)
                                      :account-from account-from)))))))


(defun import-csv (file)
  (values (import-csv-core (cl-csv:read-csv file))
          *accounts*))
