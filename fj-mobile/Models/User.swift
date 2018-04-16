//
//  User.swift
//  fj-mobile
//
//  Created by Tony Cioara on 3/22/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation

class User: Codable {
    
    var nickname: String
    var email: String
    var first_name: String
    var last_name: String
    var profile_image_file_url: String
    var token: String
    var id: Int
    
    init(nickname: String, email: String, firstName: String, lastName: String, password: String, profile_image_file_url: String, token: String, id: Int) {
        self.nickname = nickname
        self.email = email
        self.first_name = firstName
        self.last_name = lastName
        self.token = token
        self.profile_image_file_url = profile_image_file_url
        self.id = id
    }
}
