//
//  SignUpViewController.swift
//  FuwaCar
//
//  Created by Lutz Weigold on 26.05.20.
//  Copyright © 2020 Lutz Weigold. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var SignUpUserProfileImage: UIImageView!
    @IBOutlet weak var SignUpUserTextField: UITextField!
    @IBOutlet weak var SignUpEmailTextField: UITextField!
    @IBOutlet weak var SignUpPasswordTextField: UITextField!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var SignInButton: UIButton!
    @IBOutlet weak var SignUpPhoneNumberTextField: UITextField!
    
    // MARK: - Variablen
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        addTargetToTextField()
        addTapGestureToImageView()
    }
    

    
    // MARK: - Styling
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
        
        SignUpPhoneNumberTextField.attributedPlaceholder = NSAttributedString(string: SignUpPhoneNumberTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 31.0/255.0, green: 33.0/255.0, blue: 46.0/255.0, alpha: 0.64)])
        SignUpPhoneNumberTextField.layer.borderWidth = 2
        SignUpPhoneNumberTextField.layer.cornerRadius = 8
        SignUpPhoneNumberTextField.layer.borderColor = UIColor(red: 31.0/255.0, green: 33.0/255.0, blue: 46.0/255.0, alpha: 0.64).cgColor
        
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
        SignUpPhoneNumberTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(){
        // Prüfe ob Texte leer sind
        let isText = SignUpUserTextField.text?.count ?? 0 > 0 && SignUpEmailTextField.text?.count ?? 0 > 0 && SignUpPasswordTextField.text?.count ?? 0 > 0 && SignUpPhoneNumberTextField.text?.count ?? 0 > 0 && SignUpPhoneNumberTextField.text?.count ?? 0 > 0
        
        if isText{
            SignUpButton.backgroundColor = UIColor(red: 31.0/255.0, green: 33.0/255.0, blue: 46.0/255.0, alpha: 1.0)
            SignUpButton.isEnabled = true
        } else{
            SignUpButton.backgroundColor = UIColor(red: 31.0/255.0, green: 33.0/255.0, blue: 46.0/255.0, alpha: 0.64)
            SignUpButton.isEnabled = false
        }
    }
    
    
    // MARK: - Dismiss keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    // MARK: - Choose userimage
    // Tap-Gesture
    func addTapGestureToImageView(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSelectUserImage))
        SignUpUserProfileImage.addGestureRecognizer(tapGesture)
        SignUpUserProfileImage.isUserInteractionEnabled = true // Aktiviert Gesture
    }
    
    @objc func handleSelectUserImage(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self // Mit Deligate wird gesagt, dass der ViewController dafür verantwortlich ist
        pickerController.allowsEditing = true // Man kann z.B. zoomen
        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Das Bild aus dem Dictonary in den ImageView laden
        if let editImage = info[.editedImage] as? UIImage {
            SignUpUserProfileImage.image = editImage
            selectedImage = editImage
        } else if let originalImage = info[.originalImage] as? UIImage{
            SignUpUserProfileImage.image = originalImage
            selectedImage = originalImage
        }
        dismiss(animated: true, completion: nil) // Der Controller soll beendet werden
    }
    
    // MARK: - Actions
    
    // Back to StartScreen, Dismiss controller
    @IBAction func BackToSignInButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

    // Anmelde-Button
    @IBAction func SignUpButtonAction(_ sender: UIButton) {
        
        if selectedImage == nil {
            ProgressHUD.showError("Wähle bitte ein Profilbild")
            return
        }
        view.endEditing(true) // Tastatur wird verborgen
        guard let image = selectedImage else { return }
        guard let imageData = image.jpegData(compressionQuality: 0.1) else { return }
        ProgressHUD.show("Lade...", interaction: false)
        AuthentificationService.createUser(username: SignUpUserTextField.text!, email: SignUpEmailTextField.text!, password: SignUpPasswordTextField.text!, imageDate: imageData, phoneNumber: SignUpPhoneNumberTextField.text!, onSuccess: {
            ProgressHUD.showSucceed("Nutzer erfolgreich registriert")
            self.performSegue(withIdentifier: "signUpSegue", sender: nil) // Wenn Registrierung geklappt hat, wird man gleich eingeloggt
        }) { (error) in
            ProgressHUD.showError("Nutzer konnte nicht erstellt werden")
        }
    }
}
