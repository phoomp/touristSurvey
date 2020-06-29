//
//  LoginViewController.swift
//  Survey Storyboard 4
//
//  Created by Phoom Punpeng on 29/6/2563 BE.
//  Copyright © 2563 Phoom Punpeng. All rights reserved.
//

import Foundation
import UIKit

var form: SurveyForm?

class LoginView: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBAction func loginButton(_ sender: UIButton) {
        let username = ""
        let password = ""
        if usernameField.text == username && passwordField.text == password {
            let vcToPresent = storyboard!.instantiateViewController(identifier: "StartView")
            vcToPresent.modalPresentationStyle = .fullScreen
            vcToPresent.modalTransitionStyle = .crossDissolve
            present(vcToPresent, animated: true, completion: nil)
            returnElementsToNormal()
        }
            
        else if usernameField.text == username + " submit" && passwordField.text == password {
            // Submit form
            let submitSuccessful = submitForm(false)
            if submitSuccessful {
                statusLabel.text = "Data submission successful!"
            }
            else {
                statusLabel.text = "Data submission failed!"
            }
        }
            
        else if usernameField.text == "" || passwordField.text == "" {
            statusLabel.text = "Please fill in both boxes!"
        }
            
        else {
            statusLabel.text = "Invalid credentials!"
        }
    }
    
    func returnElementsToNormal() {
        statusLabel.text = ""
        usernameField.text = ""
        passwordField.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


func a() {
    return
}
