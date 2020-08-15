(in-package :vpass.importer)


(defclass account ()
  ((code  :initarg :code  :accessor code)
   (owner :initarg :owner :accessor owner)
   (name  :initarg :name  :accessor name)))


(defun account-p (v)
  (eq 'account (class-name (class-of v))))


(defun line-account-p (line)
  (= 3 (length line)))


(defun line2account (line)
  (let ((name (third line)))
    (let ((account (gethash name *accounts*)))
      (or account
          (make-instance 'account
                         :code  (second line)
                         :owner (first line)
                         :name  name)))))
