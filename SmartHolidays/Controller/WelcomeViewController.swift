//
//  WelcomeViewController.swift
//  SmartHolidays
//
//  Created by 1 on 9/4/19.
//  Copyright © 2019 1. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    
    lazy var welcomeLabel: UILabel = {
     let welcomeLabel = UILabel()
        welcomeLabel.text = "Welcome"
        welcomeLabel.font = UIFont(name: "Avenir-Medium", size: 25)
        welcomeLabel.backgroundColor = UIColor(red: 128.0/255.0, green: 201.0/255.0, blue: 244.0/255.0, alpha: 1.0)
        welcomeLabel.textColor = .white
        return welcomeLabel
    }()
    
    lazy var signUpButton: UIButton = {
        let signUpButton = customButton("Sign Up", .yellow, .blue)
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        return signUpButton
    }()
    
    lazy var logInButton: UIButton = {
        let logInButton = customButton("Log In", .yellow, .blue)
        logInButton.addTarget(self, action: #selector(logInTapped), for: .touchUpInside)
        return logInButton
    }()
    
    lazy var forgotPasswordButton: UIButton = {
        let forgotPasswordButton = customButton("Forgot Password", .yellow, .blue)
        forgotPasswordButton.addTarget(self, action: #selector(forgetPasswordTapped), for: .touchUpInside)
        return forgotPasswordButton
    }()
    
    func customButton(_ title: String ,_ titleColor: UIColor,_ backgroundColor: UIColor) -> UIButton {
            let button = UIButton()
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 20)
            button.setTitleColor(titleColor, for: .normal)
            button.backgroundColor = backgroundColor
            return button
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        signUpButton.layer.cornerRadius = signUpButton.frame.width * 0.1
        logInButton.layer.cornerRadius = logInButton.frame.width * 0.1
        forgotPasswordButton.layer.cornerRadius = forgotPasswordButton.frame.width * 0.1
  
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(welcomeLabel)
        self.view.addSubview(signUpButton)
        self.view.addSubview(logInButton)
        self.view.addSubview(forgotPasswordButton)
        
        welcomeLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(UIApplication.shared.statusBarFrame.height + self.navigationController!.navigationBar.frame.height + 10)
            make.centerX.equalToSuperview()
        }
     
        //OFFSET: ВНИЗ + , НАВЕРХ -
        
        
        logInButton.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(forgotPasswordButton)
        }
        
        signUpButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(logInButton.snp.top).offset(-20)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(forgotPasswordButton)
        }
        
        forgotPasswordButton.snp.makeConstraints { (make) in
            make.top.equalTo(logInButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(signUpButton)
            make.width.equalToSuperview().offset(-60)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @objc func signUpTapped() {
//       self.navigationController?.popViewController(animated: true)
        self.navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
    
    @objc func logInTapped() {
     self.navigationController?.pushViewController(LogInViewController(), animated: true)
    }
    
    @objc func forgetPasswordTapped() {
       self.navigationController?.pushViewController(ForgotPasswordViewController(), animated: true)
    }
}
