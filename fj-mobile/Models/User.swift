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
    
//Getting
    
    //Make user defaults to hold information of particular user

    //Make enum extension model
    
    
//    Research if it needs a password or not
    
//    static let sharedInstance = User()
    
//    static func sharedInstanceWith(username: String, monsters: [Monster], points: Int, level: Int) -> User {
//        //We don't need to have the requests or friends, because we just pass to the server the username, and we can search for the User Object in our database, so that means we shouldn't have to make any changes for when we added requests
//        let instance = User.sharedInstance
//        instance.username = username
//        instance.email = username
//        instance.monsters = monsters
//        instance.points = points
//        instance.level = level
//        return instance
//    }
//
//    init(username: String, email: String, points: Int, level: Int) {
//        self.username = username
//        self.email = email
//        self.monsters = []
//        self.points = points
//        self.level = level
//    }
    
    
//    convenience init(username: String = "", points: Int = 0, level: Int = 0) {
//        self.init(username: username, email: username, points: points, level: level)
//    }
}
