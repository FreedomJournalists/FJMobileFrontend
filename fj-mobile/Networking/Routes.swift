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
    
    func queryParameters() -> [String : String] {
        switch self {
        case .login(email, password):
            return ["email": email, "password": password]
        default:
            [:]
        }
    }
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
        case let .signUp(email, firstName, lastName, nickname, password):
            let encoder = JSONEncoder()
            let body: [String: String] = ["email": email, "first_name": firstName, "last_name": lastName, "nickname": nickname, "password": password]
            let result = try? encoder.encode(body)
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
            return ["Content-Type": "application/json", "Authorization":"Bearer 32f1dcdd06a598cc5d183cca179dc5be"]
        }
    }
}
