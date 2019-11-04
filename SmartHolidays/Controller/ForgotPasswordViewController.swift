//
//  ForgotPasswordViewController.swift
//  SmartHolidays
//
//  Created by 1 on 9/5/19.
//  Copyright © 2019 1. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
import SCLAlertView

class ForgotPasswordViewController: UIViewController {

    lazy var forgotTextField: UITextField = {
        let forgotTextField = UITextField()
        forgotTextField.placeholder = "Email"
        forgotTextField.font = UIFont(name: "Avenir-Medium", size: 20)
        forgotTextField.backgroundColor = UIColor(ciColor: .yellow)
        return forgotTextField
    }()
    
    lazy var resetPasswordButton: UIButton = {
        let resetPasswordButton = UIButton()
        resetPasswordButton.setTitle("Reset Password", for: .normal)
        resetPasswordButton.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 20)
        resetPasswordButton.setTitleColor(.white, for: .normal)
        resetPasswordButton.backgroundColor = UIColor(ciColor: .blue)
        resetPasswordButton.addTarget(self, action: #selector(resetPasswordTapped), for: .touchUpInside)
        return resetPasswordButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
         self.view.backgroundColor = .white
        self.view.addSubview(forgotTextField)
        self.view.addSubview(resetPasswordButton)
        
        forgotTextField.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.centerX.centerY.equalTo(250)
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
        }
        
        resetPasswordButton.snp.makeConstraints { (make) in
            make.top.equalTo(forgotTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(resetPasswordButton)
            make.width.equalToSuperview().offset(-60)
        }
    }
    
    
    @objc func resetPasswordTapped() {
        
        let navController = UINavigationController(rootViewController: WelcomeViewController())
        self.present(navController, animated: true, completion: nil)
        
        Auth.auth().sendPasswordReset(withEmail: forgotTextField.text!) { (error) in
            if error != nil {
                print(error!)
                SVProgressHUD.dismiss()
                SCLAlertView().showError
            } else {
                print("Password Reseted")
                SVProgressHUD.dismiss()
                SCLAlertView().showSuccess
                self.present(WelcomeViewController(), animated: true)
            }
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
