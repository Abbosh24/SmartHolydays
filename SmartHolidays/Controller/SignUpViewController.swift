//
//  SignUpViewController.swift
//  SmartHolidays
//
//  Created by 1 on 9/5/19.
//  Copyright © 2019 1. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
import SCLAlertView

class SignUpViewController: UIViewController {
    
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
    
    lazy var signUpButton: UIButton = {
        let signUpButton = UIButton()
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 20)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.backgroundColor = UIColor(ciColor: .blue)
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        return signUpButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(emailTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(signUpButton)
        
        
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
        
        signUpButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(signUpButton)
            make.width.equalToSuperview().offset(-60)
        }
      
        let countryCode = NSLocale.current.regionCode
        title = countryCode
        UserDefaults.standard.setValue(countryCode, forKey: "countryCode")
    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func signUpTapped() {
    
     let navController = UINavigationController(rootViewController: HolidaysViewController())
      self.present(navController, animated: true, completion: nil)
        
        SVProgressHUD.show()
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                print(error!)
                SVProgressHUD.dismiss()
                SCLAlertView().showError("lhk", subTitle: "3213")
                
            } else {
                print("Registration Succeeded!")
                self.sendVerificationMail()
                SCLAlertView().showSuccess
            }
        }
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
                self.navigationController?.pushViewController(LogInViewController(), animated: true)
            })
        }
        else {
            // Either the user is not available, or the user is already verified.
            SVProgressHUD.dismiss()
        }
    }
    

}
