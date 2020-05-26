//
//  SignInViewController.swift
//  FuwaCar
//
//  Created by Lutz Weigold on 26.05.20.
//  Copyright © 2020 Lutz Weigold. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var SignInEmailTextField: UITextField!
    @IBOutlet weak var SignInPasswordTextField: UITextField!
    @IBOutlet weak var SignInButton: UIButton!
    @IBOutlet weak var SignUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        addTargetToTextField()
    }
    
    
    //MARK: - Methoden
    func setUpViews(){
        // Text Fields
        SignInEmailTextField.attributedPlaceholder = NSAttributedString(string: SignInEmailTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 31.0/255.0, green: 33.0/255.0, blue: 46.0/255.0, alpha: 0.64)])
        SignInEmailTextField.layer.borderWidth = 2
        SignInEmailTextField.layer.cornerRadius = 8
        SignInEmailTextField.layer.borderColor = UIColor(red: 31.0/255.0, green: 33.0/255.0, blue: 46.0/255.0, alpha: 0.64).cgColor
        
        SignInPasswordTextField.attributedPlaceholder = NSAttributedString(string: SignInPasswordTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 31.0/255.0, green: 33.0/255.0, blue: 46.0/255.0, alpha: 0.64)])
        SignInPasswordTextField.layer.borderWidth = 2
        SignInPasswordTextField.layer.cornerRadius = 8
        SignInPasswordTextField.layer.borderColor = UIColor(red: 31.0/255.0, green: 33.0/255.0, blue: 46.0/255.0, alpha: 0.64).cgColor
        
        //Buttons
        SignInButton.layer.cornerRadius = 8
        SignInButton.backgroundColor = UIColor(red: 31.0/255.0, green: 33.0/255.0, blue: 46.0/255.0, alpha: 0.64)
        SignInButton.isEnabled = false
        
        SignUpButton.layer.cornerRadius = 8
        SignUpButton.layer.borderWidth = 2
        SignUpButton.layer.borderColor = UIColor(red: 31.0/255.0, green: 33.0/255.0, blue: 46.0/255.0, alpha: 1.0).cgColor
    }
    
    func addTargetToTextField(){
        SignInEmailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        SignInPasswordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(){
        // ?? Nil colession operator; Wenn Kein Wert nehme anstatt nil -> 0
        let isText = SignInEmailTextField.text?.count ?? 0 > 0 && SignInPasswordTextField.text?.count ?? 0 > 0
        
        if isText{
            SignInButton.backgroundColor = UIColor(red: 31.0/255.0, green: 33.0/255.0, blue: 46.0/255.0, alpha: 1.0)
            SignInButton.isEnabled = true
        } else {
            SignInButton.backgroundColor = UIColor(red: 31.0/255.0, green: 33.0/255.0, blue: 46.0/255.0, alpha: 0.64)
            SignInButton.isEnabled = false
        }
        
    }
    
    // MARK: - Actions
    @IBAction func SignInButtonAction(_ sender: Any) {
        print("Login freigeschaltet")
    }
}
