# FuwaCar

## Beschreibung
Bei der Anwendung handelt es sich um eine Mitfahrgelegenheit-App bei der Andwender Fahrten inserieren können.


Derzeit sind folgende Features implementiert:
+ Registirerung
+ Anmeldung
+ Abmeldung
+ Fahrten inserieren
+ Inserate abrufen
+ Fahrer telefonisch kontaktieren
+ Profil bearbeiten

---
## Firebase Authentification 
### Registrierung
```Swift
import FirebaseAuth class myViewController: UIViewController{
  Auth.auth().createUser(username: „Name“, email: „email@email.de“, password: „12345“, onSuccess: {
    // Registrierung erfolgreich
  }) { (error) in
    // Registrierung fehlerhaft ….
  }
}
```
### Anmeldung 
```Swift
import FirebaseAuth class myViewController: UIViewController{
  Auth.auth().signIn(email: „email@email.de“, password: „12345“, onSuccess: { 
    // Registrierung erfolgreich …
  }) { (error) in 
    // Fehlgeschlagene Anmeldung ...
  } 
}
```
## Firebase Realtime Database
### Daten hochladen 
```Swift
let speicherOrt = Database.database().reference().child("zweig1").child(„zweig2“)
speicherOrt.setValue(["username": username, "email": email, "phoneNumber": phoneNumber, "profilImageURL": profileImageURLString ?? "Kein Bild vorhanden"])
```
### Daten Abfragen 
```Swift
let dataURL = Database.database().reference().child("zweig1")
dataURL.observe(.childAdded) { (snapshot) in 
  guard let dic = snapshot.value as? [String: Any] else {return} 
}
```
