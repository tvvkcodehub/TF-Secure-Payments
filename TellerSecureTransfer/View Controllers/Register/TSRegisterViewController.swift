//
//  TSRegisterViewController.swift
//  TellerSecureTransfer
//
//  Created by Vamsi Krishna Tirumala on 20/02/21.
//

import UIKit

protocol TSRegisterViewControllerDelegate : class {
    func registerClosed()    
}

class TSRegisterViewController: UIViewController {
    
    @IBOutlet weak var crossButton: UIButton!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    weak var delegate:TSRegisterViewControllerDelegate! = nil
    var calendarPopOver = TSDatePickerPopOverController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        userNameTextField.delegate = self
        passwordTextField.delegate = self
        phoneNumberTextField.delegate = self
        emailTextField.delegate = self
        dobTextField.delegate = self
        
        passwordTextField.textContentType = .oneTimeCode                
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(false)
    }

    @IBAction func registerTapped(_ sender: Any) {
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
        else if (self.phoneNumberTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
            presentSystemAlert(title: APP_NAME, message: "Phone Number is required.", actionTitles: ["OK"], actions:
                [
                    {OKAction in
                        
                    }
                ])
        }
        else if (self.emailTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
            presentSystemAlert(title: APP_NAME, message: "Email is required.", actionTitles: ["OK"], actions:
                [
                    {OKAction in
                        
                    }
                ])
        }
        else if (self.dobTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
            presentSystemAlert(title: APP_NAME, message: "Date of Birth is required.", actionTitles: ["OK"], actions:
                [
                    {OKAction in
                        
                    }
                ])
        }
        else {
            // Save in Core Data by encrypting all the fields.
            let user = TSUser(_userName: userNameTextField.text!, _password: passwordTextField.text!, _phoneNumber: phoneNumberTextField.text!, _email: emailTextField.text!, _dob: dobTextField.text!)
            if TSCoreDataController.shared.InsertUser(_userModel: ENTITY_USER, with: user) == true {
                presentSystemAlert(title: APP_NAME, message: "Registered Succesfully.", actionTitles: ["OK"], actions:
                    [
                        {OKAction in
                            self.delegate.registerClosed()
                        }
                    ])
            }
            else {
                presentSystemAlert(title: APP_NAME, message: "Error in registering.", actionTitles: ["OK"], actions:
                    [
                        {OKAction in
                            
                        }
                    ])
            }
        }
    }
    
    @IBAction func crossTapped(_ sender: Any) {
        delegate.registerClosed()
    }

}

// MARK: UITextFieldDelegates
extension TSRegisterViewController : UITextFieldDelegate {
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
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        
        var result = false
        
        if textField == dobTextField {
            result = false
            self.calendarPopOver = TSDatePickerPopOverController()
            self.calendarPopOver.view.backgroundColor = UIColor.white
            calendarPopOver.preferredContentSize = CGSize(width: 350, height: 400)
            calendarPopOver.modalPresentationStyle = .popover
            calendarPopOver.calendarPicker.maximumDate = Date()
            calendarPopOver.delegate = self
            let ppc = calendarPopOver.popoverPresentationController
            ppc?.permittedArrowDirections = .up
            ppc?.delegate = self
            ppc!.sourceView = textField
            ppc?.sourceRect = textField.bounds
            present(calendarPopOver, animated: true, completion: nil)
        }
        else {
            result = true
        }
        
        return result
    }
}

extension TSRegisterViewController: TSCalendarPopOverControllerDelegate, UIPopoverPresentationControllerDelegate {
    func doneSelectedDate(selectedDate: String) {
        self.calendarPopOver.dismiss(animated: true) {
        }
        
        dobTextField.text = selectedDate
    }
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController){
        
    }
    
    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        // Tells iOS that we do NOT want to adapt the presentation style for iPhone
        return .none
    }
    
    func cancelCalendar() {
        self.calendarPopOver.dismiss(animated: true) {
        }
    }
}
