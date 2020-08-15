(defpackage vpass
  (:use :cl :vpass.importer)
  (:export :import-csv))
(in-package :vpass)


(export 'csv2data)


(defun csv2data (file &key (output-format :plist))
  (import-csv file :output-format output-format))
