(defpackage vpass
  (:use :cl :vpass.importer)
  (:export :import-csv))
(in-package :vpass)


(defun files2data ()
  (let ((files '("201910.csv" "201911.csv" "201912.csv"
                 "202001.csv" "202002.csv" "202003.csv"
                 "202004.csv" "202005.csv" "202006.csv"
                 "202007.csv" "202008.csv"))
        (file-path "c:/Users/yanqi/OneDrive/家計/")
        (trades nil)
        (accounts nil))
    (dolist (file files)
      (multiple-value-bind (trades-manthly accounts-tmp)
          (import-csv (merge-pathnames file file-path))
        (setf trades (nconc trades trades-manthly))
        (setf accounts accounts-tmp)))
    (values trades accounts)))


(defun account-list ()
  (multiple-value-bind (trades accounts)
      (files2data)
    (declare (ignore trades))
    (format t "~{~S~%~}~%"
            (sort (mapcar #'first
                          (alexandria:hash-table-alist accounts))
                  #'(lambda (a b) (string< a b))))))
