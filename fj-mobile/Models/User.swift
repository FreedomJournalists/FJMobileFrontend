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
    var imageUrl: URL
    
    static let sharedInstance = User()
    
    static func sharedInstanceWith(nickname: String, email: String, firstName: String, lastName: String, password: String/*, imageUrl: URL*/) -> User {
        //We don't need to have the requests or friends, because we just pass to the server the username, and we can search for the User Object in our database, so that means we shouldn't have to make any changes for when we added requests
        let instance = User.sharedInstance
        instance.nickname = nickname
        instance.email = email
        instance.firstName = firstName
        instance.lastName = lastName
        instance.password = password
        //instance.imageUrl = imageUrl
        return instance
    }
    
    init(nickname: String, email: String, firstName: String, lastName: String, password: String/*, imageUrl: URL?*/) {
        self.nickname = nickname
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.password = password
        //self.imageUrl = imageUrl!
    }
    
    
//    convenience init(username: String = "", points: Int = 0, level: Int = 0) {
//        self.init(username: username, email: username, points: points, level: level)
//    }
//Getting
    
    //Make user defaults to hold information of particular user

    //Make enum extension model
    
    
//    Research if it needs a password or not
//    
//    static let sharedInstance = User()
//    
//    static func sharedInstanceWith(nickname: String, email: String, firstName: String, lastName: String) -> User {
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
