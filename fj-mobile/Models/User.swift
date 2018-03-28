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
    var firstName: String
    var lastName: String
    var password: String
    var imageUrlString: String
    
    static let sharedInstance = User()
    
    static func sharedInstanceWith(nickname: String, email: String, firstName: String, lastName: String, password: String, imageUrlString: String) -> User {
        //We don't need to have the requests or friends, because we just pass to the server the username, and we can search for the User Object in our database, so that means we shouldn't have to make any changes for when we added requests
        let instance = User.sharedInstance
        instance.nickname = nickname
        instance.email = email
        instance.firstName = firstName
        instance.lastName = lastName
        instance.password = password
        instance.imageUrlString = imageUrlString
        return instance
    }
    
    init(nickname: String, email: String, firstName: String, lastName: String, password: String, imageUrlString: String) {
        self.nickname = nickname
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.password = password
        self.imageUrlString = imageUrlString
    }
    
    convenience init() {
        self.init(nickname: "", email: "", firstName: "", lastName: "", password: "", imageUrlString: "")
    }
}
