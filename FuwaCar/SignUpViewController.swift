//
//  SignUpViewController.swift
//  FuwaCar
//
//  Created by Lutz Weigold on 26.05.20.
//  Copyright © 2020 Lutz Weigold. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var SignUpUserProfileImage: UIImageView!
    @IBOutlet weak var SignUpUserTextField: UITextField!
    @IBOutlet weak var SignUpEmailTextField: UITextField!
    @IBOutlet weak var SignUpPasswordTextField: UITextField!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var SignInButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        addTargetToTextField()
    }
    

    
    // MARK: - Methoden
    func setUpViews(){
        // Images
        SignUpUserProfileImage.layer.cornerRadius = SignUpUserProfileImage.frame.width / 2
        SignUpUserProfileImage.layer.borderColor = UIColor(red: 168.0/255.0, green: 79.0/255.0, blue: 75.0/255.0, alpha: 1.0).cgColor
        SignUpUserProfileImage.layer.borderWidth = 8
        
        // Text Fields
        SignUpUserTextField.attributedPlaceholder =  NSAttributedString(string: SignUpUserTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 31.0/255.0, green: 33.0/255.0, blue: 46.0/255.0, alpha: 0.64)])
        SignUpUserTextField.layer.borderWidth = 2
        SignUpUserTextField.layer.cornerRadius = 8
        SignUpUserTextField.layer.borderColor = UIColor(red: 31.0/255.0, green: 33.0/255.0, blue: 46.0/255.0, alpha: 0.64).cgColor
        
        SignUpEmailTextField.attributedPlaceholder = NSAttributedString(string: SignUpEmailTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 31.0/255.0, green: 33.0/255.0, blue: 46.0/255.0, alpha: 0.64)])
        SignUpEmailTextField.layer.borderWidth = 2
        SignUpEmailTextField.layer.cornerRadius = 8
        SignUpEmailTextField.layer.borderColor = UIColor(red: 31.0/255.0, green: 33.0/255.0, blue: 46.0/255.0, alpha: 0.64).cgColor
        
        SignUpPasswordTextField.attributedPlaceholder = NSAttributedString(string: SignUpPasswordTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 31.0/255.0, green: 33.0/255.0, blue: 46.0/255.0, alpha: 0.64)])
        SignUpPasswordTextField.layer.borderWidth = 2
        SignUpPasswordTextField.layer.cornerRadius = 8
        SignUpPasswordTextField.layer.borderColor = UIColor(red: 31.0/255.0, green: 33.0/255.0, blue: 46.0/255.0, alpha: 0.64).cgColor
        
        // Buttons
        SignUpButton.layer.cornerRadius = 8
        SignUpButton.backgroundColor = UIColor(red: 31.0/255.0, green: 33.0/255.0, blue: 46.0/255.0, alpha: 0.64)
        SignUpButton.isEnabled = false
        
        SignInButton.layer.cornerRadius = 8
        SignInButton.layer.borderWidth = 2
        SignInButton.layer.borderColor = UIColor(red: 31.0/255.0, green: 33.0/255.0, blue: 46.0/255.0, alpha: 1.0).cgColor
    }
    
    
    func addTargetToTextField(){
        // Führe Methode aus, wenn Text geändert wird
        SignUpUserTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        SignUpEmailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        SignUpPasswordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(){
        // Prüfe ob Texte leer sind
        let isText = SignUpUserTextField.text?.count ?? 0 > 0 && SignUpEmailTextField.text?.count ?? 0 > 0 && SignUpPasswordTextField.text?.count ?? 0 > 0
        
        if isText{
            SignUpButton.backgroundColor = UIColor(red: 31.0/255.0, green: 33.0/255.0, blue: 46.0/255.0, alpha: 1.0)
            SignUpButton.isEnabled = true
        } else{
            SignUpButton.backgroundColor = UIColor(red: 31.0/255.0, green: 33.0/255.0, blue: 46.0/255.0, alpha: 0.64)
            SignUpButton.isEnabled = false
        }
    }
    // MARK: - Actions
    @IBAction func BackToSignInButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func SignUpButtonAction(_ sender: UIButton) {
        print("Registrierung freigeschaltet")
    }
}
