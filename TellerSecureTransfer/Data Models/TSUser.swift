//
//  TSUser.swift
//  TellerSecureTransfer
//
//  Created by Vamsi Krishna Tirumala on 20/02/21.
//

import UIKit

struct TSUser {
    var userName : String?
    var password : String?
    var phoneNumber : String?
    var email : String?
    var dob : String?
    
    init(_userName : String , _password : String, _phoneNumber : String, _email : String, _dob: String) {
        self.userName = _userName
        self.password = _password
        self.phoneNumber = _phoneNumber
        self.email = _email
        self.dob = _dob
    }
}
