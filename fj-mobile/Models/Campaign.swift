//
//  Campaign.swift
//  fj-mobile
//
//  Created by Egon Fiedler on 3/27/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import UIKit

class Campaign: Codable {
    
    var title: String
    var description: String
    var money_raised: Int
    var goal: Int
    var campaign_pledges: [Pledges]!
    var imageUrlString: String!
    
    init(title: String, description: String, money_raised: Int, goal: Int, campaign_pledges: [Pledges], imageUrlString: String) {
        self.title = title
        self.description = description
        self.money_raised = money_raised
        self.goal = goal
        self.campaign_pledges = campaign_pledges
        self.imageUrlString = imageUrlString
    }
}
