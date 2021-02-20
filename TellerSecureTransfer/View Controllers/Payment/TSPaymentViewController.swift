//
//  TSPaymentViewController.swift
//  TellerSecureTransfer
//
//  Created by Vamsi Krishna Tirumala on 20/02/21.
//

import UIKit
import Razorpay

class TSPaymentViewController: UIViewController {
    
    @IBOutlet weak var loggedInUsernameLabel: UILabel!
    @IBOutlet weak var proceedPaymentButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    
    //MARK: Instance Variables
    private var razorPay: RazorpayCheckout?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        initRazorPay()
    }
    
    internal func initRazorPay() -> Void {
        razorPay = RazorpayCheckout.initWithKey("", andDelegate: self)
    }
    
    internal func showPaymentForm() -> Void {
        let options: [String:Any] = [
            "amount":"10000",
            "description":"TellerFintech Secure Transfer",
            "image":"https://cdn.teller.io/web/images/logo-f95c6f1215ddf9d2b4a5c23f3f7ae3a4.svg?vsn=d",
            "name":"",
            "prefill":[
                "contact":PAYMENT_MOBILE,
                "email":"kvvamsi816@gmail.com"
            ],
            "theme":[
                "theme":"#87AF4E"
            ]
        ]
        
        razorPay?.open(options, displayController: self)
    }
    
    @IBAction func proceedPaymentTapped(_ sender: Any) {
        showPaymentForm()
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        presentSystemAlert(title: APP_NAME, message: "Do you want to logout?", actionTitles: ["YES", "NO"], actions:
            [
                { YesAction in
                    TSApplicationController.shared.logOut()
                },
                { NoAction in
                    //print("No")
                }
            ])
    }
}

extension TSPaymentViewController: RazorpayPaymentCompletionProtocol {
    func onPaymentSuccess(_ payment_id: String) {
        presentSystemAlert(title: APP_NAME, message: "Payment Success.", actionTitles: ["OK"], actions:
            [
                {okAction in
                    
                },nil
            ])
    }
    
    func onPaymentError(_ code: Int32, description str: String) {
        presentSystemAlert(title: APP_NAME, message: str, actionTitles: ["OK"], actions:
            [
                {okAction in
                    
                },nil
            ])
    }
}
