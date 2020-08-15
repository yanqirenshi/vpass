(defpackage vpass/tests/main
  (:use :cl
        :vpass
        :rove))
(in-package :vpass/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :vpass)' in your Lisp.

(deftest test-target-1
  (testing "should (= 1 1) to be true"
    (ok (= 1 1))))
