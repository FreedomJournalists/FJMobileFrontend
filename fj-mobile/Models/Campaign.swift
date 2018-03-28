//
//  Campaign.swift
//  fj-mobile
//
//  Created by Tony Cioara on 3/23/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation

class Campaign: Codable {
    
    var title: String
    var description: String
    var moneyRaised: Float
    var goal: Int
    var imageUrlString: String
    
    static let sharedInstance = Campaign()
    
    static func sharedInstanceWith(title: String, description: String, moneyRaised: Float, goal: Int) -> Campaign {
        
        let instance = Campaign.sharedInstance
        instance.title = title
        instance.description = description
        instance.moneyRaised = moneyRaised
        instance.goal = goal
        return instance
    }
    
    init(title: String, description: String, moneyRaised: Float, goal: Int, imageUrlString: String) {
        self.title = title
        self.description = description
        self.moneyRaised = moneyRaised
        self.goal = goal
        self.imageUrlString = imageUrlString
    }
    
    
    convenience init() {
        self.init(title: "", description: "", moneyRaised: 0.0, goal: 0, imageUrlString: "")
    }
}
