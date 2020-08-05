//
//  OfferViewController.swift
//  FuwaCar
//
//  Created by Lutz Weigold on 15.07.20.
//  Copyright © 2020 Lutz Weigold. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

class OfferViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var carDescription: UITextView!
    @IBOutlet weak var startingPoint: UITextField!
    @IBOutlet weak var destination: UITextField!
    @IBOutlet weak var departureTime: UIDatePicker!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    // MARK: - Variablen
    var selectedImage: UIImage?
    var isInput: Bool = false
    var phoneNumber: String?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Fahrten hinzufügen"
        setUpViews()
        getPhoneNumber()
        addTapGestureToImageView()
        addTargetToTextField()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataChanged()
    }
    
    
    // MARK: - Get phone Number
    func getPhoneNumber(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let refDatabaseUser = Database.database().reference().child("users").child(uid)
               refDatabaseUser.observe(.value) { (snapshot) in
                guard let dic = snapshot.value as? [String: Any] else {return}
                guard let phoneNumber = dic["phoneNumber"] as? String else {return}
                print("Telefonnummer lautet \(phoneNumber)")
                self.phoneNumber = phoneNumber
        }
    }
    // MARK: - View logic
    
    func setUpViews(){
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 243.0/255.0, green: 212.0/255.0, blue: 206.0/255.0, alpha: 0.64)
        // Images
        carImage.layer.cornerRadius = carImage.frame.width / 2
        carImage.layer.borderColor = UIColor(red: 31.0/255.0, green: 33.0/255.0, blue: 46.0/255.0, alpha: 0.64).cgColor
        carImage.layer.borderWidth = 4
    
        
        // Text Fields
        departureTime.setValue(UIColor(red: 31.0/255.0, green: 33.0/255.0, blue: 46.0/255.0, alpha: 0.64), forKeyPath: "textColor")
        
        startingPoint.attributedPlaceholder = NSAttributedString(string: startingPoint.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 31.0/255.0, green: 33.0/255.0, blue: 46.0/255.0, alpha: 0.64)])
        startingPoint.layer.borderWidth = 2
        startingPoint.layer.cornerRadius = 8
        startingPoint.layer.borderColor = UIColor(red: 31.0/255.0, green: 33.0/255.0, blue: 46.0/255.0, alpha: 0.64).cgColor
        
        destination.attributedPlaceholder = NSAttributedString(string: destination.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 31.0/255.0, green: 33.0/255.0, blue: 46.0/255.0, alpha: 0.64)])
        destination.layer.borderWidth = 2
        destination.layer.cornerRadius = 8
        destination.layer.borderColor = UIColor(red: 31.0/255.0, green: 33.0/255.0, blue: 46.0/255.0, alpha: 0.64).cgColor
        
        carDescription.layer.borderWidth = 2
        carDescription.layer.cornerRadius = 8
        carDescription.layer.borderColor = UIColor(red: 31.0/255.0, green: 33.0/255.0, blue: 46.0/255.0, alpha: 0.64).cgColor
        
        departureTime.layer.borderWidth = 2
        departureTime.layer.cornerRadius = 8
        departureTime.layer.borderColor = UIColor(red: 31.0/255.0, green: 33.0/255.0, blue: 46.0/255.0, alpha: 0.64).cgColor
        
        //Buttons
        shareButton.layer.cornerRadius = 8
        shareButton.backgroundColor = UIColor(red: 31.0/255.0, green: 33.0/255.0, blue: 46.0/255.0, alpha: 0.64)
        shareButton.isEnabled = false
        
        cancelButton.layer.cornerRadius = 8
        cancelButton.layer.borderWidth = 2
        cancelButton.layer.borderColor = UIColor(red: 31.0/255.0, green: 33.0/255.0, blue: 46.0/255.0, alpha: 1.0).cgColor
        cancelButton.isEnabled = true
        
    }
    
    func addTargetToTextField(){
        // Führe Methode aus, wenn Text geändert wird
        startingPoint.addTarget(self, action: #selector(dataChanged), for: .editingChanged)
        destination.addTarget(self, action: #selector(dataChanged), for: .editingChanged)
    }
        
    @objc func dataChanged(){
        isInput = selectedImage != nil && carDescription.text?.count ?? 0 > 0 && startingPoint.text?.count ?? 0 > 0 && destination.text?.count ?? 0 > 0
        
        
        if isInput{
            shareButton.isEnabled = true
            shareButton.backgroundColor = UIColor(red: 31.0/255.0, green: 33.0/255.0, blue: 46.0/255.0, alpha: 1.0)
            return
        } else{
            shareButton.backgroundColor = UIColor(red: 31.0/255.0, green: 33.0/255.0, blue: 46.0/255.0, alpha: 0.64)
            shareButton.isEnabled = false
        }
    }
    
    
    // MARK: - Choose car image
    func addTapGestureToImageView(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSeelctPhoto))
        carImage.addGestureRecognizer(tapGesture)
        carImage.isUserInteractionEnabled = true;
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Tastatur verschwindet
        view.endEditing(true)
    }
    
    @objc func handleSeelctPhoto() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.modalPresentationStyle = .fullScreen
        pickerController.allowsEditing = true
        present(pickerController, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Das Bild aus dem Dictonary in den ImageView laden
        if let editImage = info[.editedImage] as? UIImage {
            carImage.image = editImage
            selectedImage = editImage
        } else if let originalImage = info[.originalImage] as? UIImage{
            carImage.image = originalImage
            selectedImage = originalImage
        }
        dismiss(animated: true, completion: nil) // Der Controller soll beendet werden
    }
    
    
    // MARK: - Share drive
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
        guard let image = selectedImage else {
            ProgressHUD.showError("Wähle bitte ein Profilbild")
            return
        }
    
        //Bild wird kompremiert
        guard let imageData = image.jpegData(compressionQuality: 0.1) else {return}
        ProgressHUD.show("Fahrt wird vorbereitet", interaction: false)
        let imageId = NSUUID().uuidString //Generiert einen einzigartigen String
        let storageRef = Storage.storage().reference().child("rides").child(imageId) //URL zum storage wird gespeichert, Erstelle falls noch nicht vorhanden ein Kundordner "rides" unter der Adresse erstellen und die ImageID speichern
        storageRef.putData(imageData, metadata: nil) { (metadata, error) in
            if error != nil {
                ProgressHUD.showError("Fehler beim Hochladen des Bildes")
                return
            }
            
            storageRef.downloadURL(completion: {(url, error) in
                if error != nil {
                    print("Url konnte nicht geladen werden")
                    return
                }

                guard let imageURL = url?.absoluteString else {
                    return
                }
                self.uploadDataToDatabase(imageUrl: imageURL)
            }

        )}
        
    }
    
    func uploadDataToDatabase(imageUrl: String){
        let databaseRef = Database.database().reference().child("rides")
        let newRideID = databaseRef.childByAutoId().key
        let newRideReference = databaseRef.child(newRideID!)
        
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        let day = dateFormatter.string(from: departureTime.date)
        dateFormatter.dateFormat = "MMM"
        let month = dateFormatter.string(from: departureTime.date)
        dateFormatter.dateFormat = "HH"
        let hour = dateFormatter.string(from: departureTime.date)
        dateFormatter.dateFormat = "mm"
        let minute = dateFormatter.string(from: departureTime.date)
        let dateDic = ["weekday" : day, "month" : month, "hour" : hour, "minute" : minute]
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let dic = ["imageUrl" : imageUrl, "carDescription": carDescription.text, "startingPoint" : startingPoint.text, "destination": destination.text, "departureTime": dateDic, "phoneNumber": phoneNumber, "uid":uid] as [String : Any]
        
        newRideReference.setValue(dic) { (error, ref) in
            if error != nil{
                ProgressHUD.showError("Daten konnten nicht hochgeladen werden")
                return
            }
            ProgressHUD.showSucceed("Fahrt erfolgreich geteilt")
            self.removeImput();
            self.tabBarController?.selectedIndex = 0
        }
    }
    
    
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        removeImput()
    }
    
    func removeImput(){
        selectedImage = nil
        carDescription.text = ""
        destination.text = ""
        startingPoint.text = ""
        shareButton.isEnabled = false
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        //print("Day \(day), Month \(month),Stunden: \(hour), Minuten: \(minutes)")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "dd:MM:HH:mm"

        let setDate = dateFormatter.date(from: "\(day):\(month):\(hour):\(minutes)")

        departureTime.date = setDate!
        
        //departureTime.setDate(Data(), animated: false)
        carImage.image = UIImage(named: "placeholder_car")
    }
}
