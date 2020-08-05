//
//  AuthentificationService.swift
//  FuwaCar
//
//  Created by Lutz Weigold on 15.07.20.
//  Copyright © 2020 Lutz Weigold. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage

class AuthentificationService{
    
    // MARK: - Anmeldeservice
    // onSuccess = Closure
    static func signIn(email: String, password: String, onSuccess: @escaping () -> Void, onError: @escaping (_ error: String?) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) { (data, error) in
            if let err = error{
                // Prüfen, ob es einen Fehler gibt
                onError(err.localizedDescription)
                return
            }
            // Closure wird ein Code-Block übergeben, Wird be Erfolg ausgeführt
            onSuccess()
        }
    }
    
    
    // MARK: - Ausloggen
    static func logOut(onSuccess: @escaping () -> Void, onError: @escaping (_ error: String?) -> Void){
        do{
            //Versuche auszuloggen
            try Auth.auth().signOut()
            print("User ist ausgeloggt")
        } catch let logOutError { //Wenn schiefgeht, dann fange den Fehler auf
            onError(logOutError.localizedDescription)
        }
        onSuccess()
    }
    
    // MARK: - Automatisches Anmelden
    static func automaticSignIn(onSuccess: @escaping () -> Void){
        if Auth.auth().currentUser != nil {
            DispatchQueue.main.async {
                // Wird nach 2 Sekunden Wartezeit ausgeführt
                Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (Timer) in
                    onSuccess()
                }
            }
        }
    }
    
    
    // MARK: - Nutzer erstellen und hochladen zu Firebase
    static func createUser(username: String, email: String, password: String, imageDate: Data, phoneNumber: String, onSuccess: @escaping () -> Void, onError: @escaping (_ error: String) -> Void){
        
        Auth.auth().createUser(withEmail: email, password: password) { (data, error) in
            if let err = error{
                // Prüfen, ob es einen Fehler gibt
                onError(err.localizedDescription)
                return
            }
            
            //Wenn User erfolgreich erstellt wurde
            guard let uid = data?.user.uid else{return}
            self.uploadUserDate(uid: uid, username: username, email: email, imageDate: imageDate, phoneNumber: phoneNumber, onSuccess: onSuccess)
        }
    }
    
    static func uploadUserDate(uid: String, username: String, email: String, imageDate: Data, phoneNumber: String, onSuccess: @escaping () -> Void){
        let storageRef = Storage.storage().reference().child("user_images").child(uid)
        
        
        storageRef.putData(imageDate, metadata: nil) { (metadata, error) in
            if error != nil {
                return
            }
            
            
            storageRef.downloadURL(completion: {(url, error) in
                if error != nil {
                    return
                }
                
                let profileImageURLString = url?.absoluteString
                
                let ref = Database.database().reference().child("users").child(uid) // URL-Adresse zur Datenbank; Zweig hinzugefügt User; UserId als Zweig hinzugefügt; Mit Child wird der Baum erstellt.
                ref.setValue(["username": username, "email": email, "phoneNumber": phoneNumber,"profilImageURL": profileImageURLString ?? "Kein Bild vorhanden"]) // Immer als Dictonary hochladen
                       print(ref)
                onSuccess()
            })
        }
    }
}
