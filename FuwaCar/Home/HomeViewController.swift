//
//  HomeViewController.swift
//  FuwaCar
//
//  Created by Lutz Weigold on 15.07.20.
//  Copyright © 2020 Lutz Weigold. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class HomeViewController: UIViewController {

    
    
    // MARK: - Outlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var welcomeUserName: UILabel!
    @IBOutlet weak var acrivityIndicatorView: UIActivityIndicatorView!
    
    // MARK: - var / let
    var rides = [PostModel]()
    var users = [UserModel]()
    var username = "Lutz"
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentUser()
        tableView.tableFooterView = UIView(frame: .zero) //Tabellenzeilen, die nicht genutzt werden, werden ausgeblendet
        tableView.estimatedRowHeight = 500
        navigationController?.navigationBar.barTintColor = UIColor(red: 243.0/255.0, green: 212.0/255.0, blue: 206.0/255.0, alpha: 0.64)
        tableView.rowHeight = UITableView.automaticDimension
        loadRides()
        tableView.dataSource = self
    }
    
    // MARK: - Get current user
    func getCurrentUser(){

        guard let uid = Auth.auth().currentUser?.uid else {return}
         let refDatabaseUser = Database.database().reference().child("users").child(uid)
        refDatabaseUser.observe(.value) { (snapshot) in
            guard let dic = snapshot.value as? [String: Any] else {return}
            let username = dic["username"] as? String
            self.welcomeUserName.text = "Hallo \(username ?? "Namenlos"),"
         
        }

        
    }
    
    // MARK: - Fetch Users
    func fetchUser(uid: String, completed: @escaping () -> Void ){
        let refDatabaseUser = Database.database().reference().child("users").child(uid)
        //Daten werden abgefragt und sind dann im snapshot
        refDatabaseUser.observe(.value) { (snapshot) in
            guard let dic = snapshot.value as? [String: Any] else {return}
            let newUser = UserModel(dictionary: dic)
            self.users.insert(newUser, at: 0)
            completed()
        }
    }
    
    // MARK: - Load Rides
    func loadRides(){
        acrivityIndicatorView.startAnimating()
        let refDatabaseRides = Database.database().reference().child("rides")
        // .childAdded lädt life neue inhalte herunter als dictonary
        refDatabaseRides.observe(.childAdded) { (snapshot) in
            guard let dic = snapshot.value as? [String: Any] else {return} // Falls keine Daten empfangen werden oder keine Daten verfügbar sind
            let newRide = PostModel(dictionary: dic)
            
            guard let userUid = newRide.uid else { return }
            self.fetchUser(uid: userUid) {
                self.rides.insert(newRide, at: 0)
                self.acrivityIndicatorView.stopAnimating()
                self.tableView.reloadData()
                self.tableView.setContentOffset(CGPoint.zero, animated: true)
            }
        }
    }
    
    // MARK: - Log Out
    
    @IBAction func logOutButton(_ sender: UIBarButtonItem) {
        AuthentificationService.logOut(onSuccess: {
            let storyboard = UIStoryboard(name: "Start", bundle: nil)
                   let loginViewController = storyboard.instantiateViewController(identifier: "loginViewController")
            self.present(loginViewController, animated: true, completion: nil)
        }) { (error) in
            print(error!)
        }
    }
    
    //MARK: - scrollToNewRides
    
    @IBAction func scrollNewPost(_ sender: Any) {
        tableView.setContentOffset(CGPoint.zero, animated: true)
    }
}


// MARK: - Tableview Datasource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rides.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Tabellenzellen werden neu benutzt
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        cell.layer.cornerRadius=32
        cell.ride = rides[indexPath.row]
        cell.user = users[indexPath.row]
        return cell
    }
}
