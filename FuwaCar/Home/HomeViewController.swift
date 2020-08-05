//
//  HomeViewController.swift
//  FuwaCar
//
//  Created by Lutz Weigold on 15.07.20.
//  Copyright © 2020 Lutz Weigold. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .red
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
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
    
}
