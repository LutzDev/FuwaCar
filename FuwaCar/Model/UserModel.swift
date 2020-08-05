//
//  UserModel.swift
//  FuwaCar
//
//  Created by Lutz Weigold on 16.07.20.
//  Copyright © 2020 Lutz Weigold. All rights reserved.
//

import Foundation

class UserModel {
    
    var username: String?
    var email: String?
    var profileImageUrl: String?
    
    init(dictionary: [String: Any]) {
        username = dictionary["username"] as? String
        email = dictionary["email"] as? String
        profileImageUrl = dictionary["profilImageURL"] as? String
    }
}
