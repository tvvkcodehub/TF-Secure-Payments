//
//  TSLoginViewController.swift
//  TellerSecureTransfer
//
//  Created by Vamsi Krishna Tirumala on 20/02/21.
//

import UIKit

class TSLoginViewController: UIViewController, TSRegisterViewControllerDelegate {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        userNameTextField.delegate = self
        passwordTextField.delegate = self
        
        passwordTextField.textContentType = .init(rawValue: "")
                
    }
    
    deinit {
        print("Login Released.")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(false)
    }
    
    @IBAction func registerTapped(_ sender: Any) {
        let registerViewController = TSRegisterViewController(nibName: "TSRegisterViewController", bundle: Bundle.main)
        registerViewController.delegate = self
        registerViewController.modalPresentationStyle = .fullScreen
        registerViewController.modalTransitionStyle = .coverVertical
        self.navigationController?.present(registerViewController, animated: true, completion: {
            
        })
    }
    
    @IBAction func goTapped(_ sender: Any) {
        if (self.userNameTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
            presentSystemAlert(title: APP_NAME, message: "Username is required.", actionTitles: ["OK"], actions:
                [
                    {OKAction in
                        
                    }
                ])
        }
        else  if (self.passwordTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
            presentSystemAlert(title: APP_NAME, message: "Password is required.", actionTitles: ["OK"], actions:
                [
                    {OKAction in
                        
                    }
                ])
        }
        else {
            if TSCoreDataController.shared.validateUser(userName: userNameTextField.text!, password: passwordTextField.text!) == true {
                let paymentVC = TSPaymentViewController(nibName: "TSPaymentViewController", bundle: Bundle.main)
                self.navigationController?.pushViewController(paymentVC, animated: true)
            }
            else {
                presentSystemAlert(title: APP_NAME, message: "Invalid User.", actionTitles: ["OK"], actions:
                    [
                        {OKAction in
                            
                        }
                    ])
            }
        }
    }
    
    func registerClosed() {
        self.navigationController?.dismiss(animated: true, completion: {
            
        })
    }
}

// MARK: Private Functions
extension TSLoginViewController {
    func moveView(_ isUp : Bool) {
        if isUp == true {
            UIView.animate(withDuration: 0.2, animations: {
                self.holderView.center = CGPoint(x: self.holderView.center.x, y: self.holderView.center.y - 30)
            })
        }
        else if isUp == false {
            UIView.animate(withDuration: 0.2, animations: {
                self.holderView.center = CGPoint(x: self.holderView.center.x, y: self.holderView.center.y + 30)
            })
        }
    }
}

// MARK: UITextFieldDelegates
extension TSLoginViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.userNameTextField {
            let maxLength = 15
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.userNameTextField {
            self.passwordTextField.becomeFirstResponder()
        }
        else if textField == self.passwordTextField {
            self.passwordTextField.resignFirstResponder()
            //self.moveView(false)
        }
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.userNameTextField {
            self.userNameTextField.returnKeyType = .next
        }
        else if textField == self.passwordTextField {
            self.passwordTextField.returnKeyType = .done
        }
        
        //self.moveView(true)
        return
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //self.moveView(false)
    }
}
