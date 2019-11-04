//
//  LogInViewController.swift
//  SmartHolidays
//
//  Created by 1 on 9/5/19.
//  Copyright © 2019 1. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
import SCLAlertView


class LogInViewController: UIViewController {

    lazy var emailTextField: UITextField = {
        let emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        emailTextField.font = UIFont(name: "Avenir-Medium", size: 20)
        emailTextField.backgroundColor = UIColor(ciColor: .yellow)
        return emailTextField
    }()
    
    lazy var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.font = UIFont(name: "Avenir-Medium", size: 20)
        passwordTextField.backgroundColor = UIColor(ciColor: .yellow)
        
        return passwordTextField
    }()
    
    lazy var logInButton: UIButton = {
        let logInButton = UIButton()
        logInButton.setTitle("Log In", for: .normal)
        logInButton.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 20)
        logInButton.setTitleColor(.white, for: .normal)
        logInButton.backgroundColor = UIColor(ciColor: .blue)
        logInButton.addTarget(self, action: #selector(logInTapped), for: .touchUpInside)
        return logInButton
    }()


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.view.backgroundColor = .white
        self.view.addSubview(emailTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(logInButton)
        
        
        emailTextField.snp.makeConstraints { (make) in
            make.bottom.equalTo(passwordTextField.snp.top).offset(-20)
            make.height.equalTo(50)
            make.centerX.equalTo(250)
            make.left.equalTo(passwordTextField)
            make.right.equalTo(passwordTextField)
        }
        passwordTextField.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.centerX.centerY.equalTo(250)
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
        }
        
        logInButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(logInButton)
            make.width.equalToSuperview().offset(-60)
        }

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @objc func logInTapped() {
        
        let navController = UINavigationController(rootViewController: HolidaysViewController())
        self.present(navController, animated: true, completion: nil)
        
        SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                print(error!)
                SVProgressHUD.dismiss()
                SCLAlertView().showError("", subTitle: error!.localizedDescription)
            } else {
                print("Successful Log In!")
                
                let currentUser = Auth.auth().currentUser
                if currentUser != nil && !currentUser!.isEmailVerified {
                    SVProgressHUD.dismiss()
                    
                    let alertView = SCLAlertView()
                    alertView.addButton("Resend link", action: {
                        self.sendVerificationMail()
                    })
                    alertView.showWarning("Email is not verified", subTitle: "Please, verify your email first.")
                }
                if currentUser != nil && currentUser!.isEmailVerified {
                    SVProgressHUD.dismiss()
                    
                    self.present(HolidaysViewController(), animated: true)
//                    self.performSegue(withIdentifier: "goToMain", sender: self)
                }
                let countryCode = NSLocale.current.regionCode
                UserDefaults.standard.setValue(countryCode, forKey: "countryCode")
            }}
    }

    
    func sendVerificationMail() {
        let currentUser = Auth.auth().currentUser
        if currentUser != nil && !currentUser!.isEmailVerified {
            currentUser!.sendEmailVerification(completion: { (error) in
                SVProgressHUD.dismiss()
                guard error == nil else {
                    SCLAlertView().showError("Could not send cofirmation link", subTitle: error!.localizedDescription)
                    return
                }
                SCLAlertView().showSuccess("One more step...", subTitle: "Open the link that was sent to your email address")
                // Notify the user that the mail has sent or couldn't because of an error.
            })
        }
        else {
            // Either the user is not available, or the user is already verified.
            SVProgressHUD.dismiss()
        }
    }
    
}

