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
    case signUp(email: String, firstName: String, lastName: String, nickname: String, password: String/*, imageUrl: URL*/)
    
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
        case let .signUp(email, firstName, lastName, nickname, password/*, imageUrl*/):
            let user = User(nickname: nickname, email: email, firstName: firstName, lastName: lastName, password: password/*, imageUrl: imageUrl*/)
            let encoder = JSONEncoder()
            let result = try? encoder.encode(user)
            
            return result!

        default:
            return nil
        }
    }
    
//    Finish body and add func headers
}
