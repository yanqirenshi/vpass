(in-package :vpass.importer)


(defclass trade ()
  ((date                   :initarg :date                   :accessor date)
   (account-from           :initarg :account-from           :accessor account-from)
   (account-to             :initarg :account-to             :accessor account-to)
   (usage-amount           :initarg :usage-amount           :accessor usage-amount)
   (number-payments        :initarg :number-payments        :accessor number-payments)
   (number-payments-number :initarg :number-payments-number :accessor number-payments-number)
   (payment-amount         :initarg :payment-amount         :accessor payment-amount)
   (description            :initarg :description            :accessor description)))


(defun line-trade-p (line)
  (and (= 7 (length line))
       (string/= "" (first line))))


(defun date2ts (date)
  (local-time:parse-timestring date
                               :date-separator #\/
                               :offset (* 9 60 60 -1)))


(defun trade-value2integer (v)
  (if (string= "" v)
      nil
      (parse-integer v)))


(defun line2trade (line account-from)
  (make-instance 'trade
                 :date                   (date2ts (first line))
                 :account-from           account-from
                 :account-to             (line2account-to (second line))
                 :usage-amount           (trade-value2integer (third line))
                 :number-payments        (trade-value2integer (fourth line))
                 :number-payments-number (trade-value2integer (fifth line))
                 :payment-amount         (parse-integer (sixth line))
                 :description            (seventh line)))
