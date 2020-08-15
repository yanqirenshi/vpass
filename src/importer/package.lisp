(defpackage vpass.importer
  (:use :cl)
  (:import-from :alexandria
                #:when-let)
  (:export :import-csv))
(in-package :vpass.importer)

(defvar *accounts* (make-hash-table :test 'equalp))

(defvar *places* (make-hash-table :test 'equalp))
