//
//  Campaign.swift
//  fj-mobile
//
//  Created by Tony Cioara on 3/23/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation

class Campaign: Codable {
    
    var id: Int
    var title: String
    var description: String
    var money_raised: Float
    var goal: Int
    var image_file_url: String
    var user: User
    
    
    init(title: String, description: String, moneyRaised: Float, goal: Int, imageUrlString: String, id: Int, user: User) {
        self.title = title
        self.description = description
        self.money_raised = moneyRaised
        self.goal = goal
        self.image_file_url = imageUrlString
        self.id = id
        self.user = user
    }
    
}
