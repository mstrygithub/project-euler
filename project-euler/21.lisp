; This aims to be a solution for:
; http://projecteuler.net/index.php?section=problems&id=5
(asdf:oos 'asdf:load-op :iterate)
(use-package :iterate)

; a^2 + b^2 = c^2
; a + b + c = 1000
; ===>
; a^2 + b^2 = (1000-(a+b))^2
; a^2 + b^2 = 1000^2 + (a+b)^2 - 2000(a+b)
; 0 = 1000^2 + 2ab - 2000a - 2000b
; 1e6+2ab = 2000(a+b)

(defun factorize-using-factor (num factor)
  (if (not (= (mod num factor) 0))
    0
    (1+ (factorize-using-factor (/ num factor) factor))))

(defun factorize (num)
  (iter (for factor from 2)
        (until (= num 1))
        (let ((e (factorize-using-factor num factor)))
          (if (not (= e 0))
            (progn (collect (cons factor e))
                   (setq num (/ num (expt factor e))))))))

(defun num-divisors (num)
  (reduce #'* 
          (mapcar #'(lambda (pair) (1+ (cdr pair))) (factorize num))
          :initial-value 1))

(defun sum-divisors (num)
  (iter (for div from 1 to (floor (/ num 2)))
        (if (zerop (mod num div))
          (sum div))))

(defun myfind ()
  (iter (for i from 1 to (1- 10000))
        (format t "~A~%" i)
        (let ((d-i (sum-divisors i)))
          (if (and (/= i d-i)
                   (< d-i 10000)
                   (= i (sum-divisors d-i)))
            (sum i)))))
