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
    var id: Int
    var authetication_token: String!
    var user_campaigns: [Campaign]!
    var user_pledges : [Pledges]!
    var imageUrlString: String!
    
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
    
    init(nickname: String, email: String, firstName: String, lastName: String, password: String, id: Int, authetication_token: String,user_campaigns: [Campaign], user_pledges : [Pledges], imageUrlString: String) {
        self.nickname = nickname
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.password = password
        self.id = id
        self.authetication_token = authetication_token
        self.user_campaigns = user_campaigns
        self.user_pledges = user_pledges
        self.imageUrlString = imageUrlString
    }
    
    convenience init() {
        self.init(nickname: "", email: "", firstName: "", lastName: "", password: "", id: 0, authetication_token: "", user_campaigns: Campaign, user_pledges: [Pledges], imageUrlString: "")
    }
}
