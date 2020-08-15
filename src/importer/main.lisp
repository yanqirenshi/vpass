(in-package :vpass.importer)

(export 'import-csv)

(defun line2object (line &key account file-name)
  (cond ((line-account-p line) (line2account line))
        ((line-trade-p line)   (line2trade line account file-name))
        ((total-p line) nil)
        (t nil)))


(defun import-csv-core (lines &key account file-name)
  (when-let ((line (car lines)))
    (let ((obj (line2object line
                            :account   account
                            :file-name file-name)))
      (cond ((null obj)      (import-csv-core (cdr lines) :account account :file-name file-name))
            ((account-p obj) (import-csv-core (cdr lines) :account obj     :file-name file-name))
            (t (cons obj
                     (import-csv-core (cdr lines)
                                      :account account
                                      :file-name file-name)))))))

(defun make-plist-account (account)
  (concatenate 'string
               (owner account)
               ": "
               (name account)
               "(" (code account) ")"))


(defun to-plist (list)
  (when-let ((data (car list)))
    (cons (list :date    (date data)
                :account (make-plist-account (account data))
                :place   (name (place data))
                :usage-amount (usage-amount data)
                :number-payments (number-payments data)
                :number-payments-number (number-payments-number data)
                :payment-amount (payment-amount data)
                :description (description data)
                :file (file data))
          (to-plist (cdr list)))))


(defun pathname-filename (file)
  (concatenate 'string
               (pathname-name file)
               "."
               (pathname-type file)))


(defun import-csv (file &key output-format)
  (let ((trades (import-csv-core (cl-csv:read-csv file)
                                 :file-name (pathname-filename file))))
    (values (cond ((eq :plist output-format) (to-plist trades))
                  (t trades))
            *accounts*
            *places*)))
