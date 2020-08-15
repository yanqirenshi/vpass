(defsystem "vpass"
  :version "0.1.0"
  :author ""
  :license ""
  :depends-on (:cl-csv :local-time)
  :components ((:module "src"
                :components
                ((:module "importer"
                  :components
                  ((:file "package")
                   (:file "account")
                   (:file "trade")
                   (:file "total-line")
                   (:file "main")))
                 (:file "main"))))
  :description ""
  :in-order-to ((test-op (test-op "vpass/tests"))))

(defsystem "vpass/tests"
  :author ""
  :license ""
  :depends-on ("vpass"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for vpass"
  :perform (test-op (op c) (symbol-call :rove :run c)))
