//
//  Routes.swift
//  fj-mobile
//
//  Created by Tony Cioara on 3/19/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation

enum Route {
    
    case postCampaign(title: String, description: String, goal: String)
    case getAllCampaigns
    case login(email: String, password: String)
    case signUp(email: String, firstName: String, lastName: String, nickname: String, password: String)
    
    func method() -> String {
        switch self {
        case .getAllCampaigns:
            return "GET"
        case .postCampaign:
            return "POST"
        case .login:
            return "GET"
        case .signUp:
            return "POST"
        }
    }
    
    func path() -> String {
        switch self {
        case .getAllCampaigns:
            return "campaigns"
        case .postCampaign:
            return "campaigns"
        case .login:
            return "login"
        case .signUp:
            return "users"
        }
    }
    
    func body() -> Data? {
        switch self {
//        case signUp:
//            let user = User(first_name: firstName, last_name: lastName, email: email, nickname: nickname, password: password)
//            let encoder = JSONEncoder()
//            let result = try? encoder.encode(user)

        default:
            return nil
        }
    }
    
//    Finish body and add func headers
}
