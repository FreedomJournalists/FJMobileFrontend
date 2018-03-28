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
    case signUp(email: String, firstName: String, lastName: String, nickname: String, password: String, imageUrlString: String)
    
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
        case let .signUp(email, firstName, lastName, nickname, password, imageUrlString):
            let user = User(nickname: nickname, email: email, firstName: firstName, lastName: lastName, password: password, imageUrlString: imageUrlString)
            let encoder = JSONEncoder()
            let result = try? encoder.encode(user)
        
        return result!
        
        default:
            return nil
        }
    }
    
    func headers() -> [String: String] {
        switch self {
        case .login, .signUp:
            return ["Content-Type": "application/json"]
        default:
            return ["Content-Type": "application/json", "Authorization":"Bearer 314a65b195e62a34f35df589fe4caa9f"]
        }
    }
}
