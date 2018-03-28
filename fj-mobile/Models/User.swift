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
    var password: String
    var id: Int
    var authetication_token: String!
    var user_campaigns: [Campaign]!
    var user_pledges : [Pledges]!
    var image_url_string: String!
    
    static let sharedInstance = User()
    
    static func sharedInstanceWith(nickname: String, email: String, first_name: String, last_name: String, password: String, image_url_string: String) -> User {
        //We don't need to have the requests or friends, because we just pass to the server the username, and we can search for the User Object in our database, so that means we shouldn't have to make any changes for when we added requests
        let instance = User.sharedInstance
        instance.nickname = nickname
        instance.email = email
        instance.first_name = first_name
        instance.last_name = last_name
        instance.password = password
        instance.image_url_string = image_url_string
        return instance
    }
    
    init(nickname: String, email: String, first_name: String, last_name: String, password: String, id: Int, authetication_token: String,user_campaigns: [Campaign], user_pledges : [Pledges], image_url_string: String) {
        self.nickname = nickname
        self.email = email
        self.first_name = first_name
        self.last_name = last_name
        self.password = password
        self.id = id
        self.authetication_token = authetication_token
        self.user_campaigns = user_campaigns
        self.user_pledges = user_pledges
        self.image_url_string = image_url_string
    }
    
    convenience init() {
        self.init(nickname: "", email: "", first_name: "", last_name: "", password: "", id: 0, authetication_token: "", user_campaigns: Campaign, user_pledges: [Pledges], image_url_string: "")
    }
}
