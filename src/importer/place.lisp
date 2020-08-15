(in-package :vpass.importer)


(defclass place ()
  ((name  :initarg :name  :accessor name)))


(defun line2place (name)
  (let ((place (gethash name *places*)))
    (or place
        (setf (gethash name *places*)
              (make-instance 'place :name name)))))
