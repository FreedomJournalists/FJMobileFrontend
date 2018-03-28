//
//  Pledges.swift
//  fj-mobile
//
//  Created by Egon Fiedler on 3/27/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import UIKit

class Pledges: Codable {

    var money: Int
    var message: String
    
    init(money: Int, message: String) {
        self.money = money
        self.message = message
    }
}
