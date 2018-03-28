//
//  Routes.swift
//  fj-mobile
//
//  Created by Tony Cioara on 3/19/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation
import KeychainSwift

enum imageUploadRoute {
    case userUpload
    case groupUpload
    
    func fileName()-> String {
        let keychain = KeychainSwift()
        switch self {
        case .userUpload:
            let userID = keychain.get("id")
            return "User\(String(describing: userID!))Profile"
        case .groupUpload:
            let groupID = keychain.get("groupID")
            return "Group\(String(describing: groupID!))Profile"
        }
    }
    
    func Path()-> String {
        let keychain = KeychainSwift()
        switch self {
        case .userUpload:
            return "sessions"
        case .groupUpload:
            let groupID = keychain.get("groupID")
            return "groups/\(groupID!)"
        }
    }
    
    func Headers()-> [String: String] {
        let keychain = KeychainSwift()
        let token = keychain.get("token")
        let email = keychain.get("email")
        return ["x-User-Token": "\(token!)",
            "x-User-Email": email!]
    }
    
}

enum Route {
    
    ///////////////////////////////////////////////
    //Routes User Related
    //GET
    case getUser(username: String)
    //POST
    case loginUser(email: String, password: String)
    case createUser(email: String, firstName: String, lastName: String, nickname: String, password: String)
    //DELETE
    case logoutUser
    case deleteUser
    
    ////////////////////////////////////////////////
    //Routes Campaign Related
    //GET
    //campaigns
    case getAllCampaigns
    case getCampaign
    //user/campaigns
    case getUserCampaigns
    //POST
    case postCampaign(title: String, description: String, goal: String)
    //UPDATE
    //There should be one for when you create a user
    //DELETE
    case deleteCampaign
    
    ////////////////////////////////////////////////
    //Routes Pledges Related
    //GET
    case getCampaignPledges //When you are getting the campaign pledges
    //POST
    case postPledge
    //DELETE
    case deletePledge
    
    func method() -> String {
        switch self {
        case .getUser, .getAllCampaigns, .getCampaign, .getUserCampaigns, .getCampaignPledges:
            return "GET"
        case .loginUser, .createUser, .postCampaign, .postPledge:
            return "POST"
        case .logoutUser, .deleteUser, .deleteCampaign, .deletePledge:
            return "DELETE"
        }
    }
    
    func path() -> String {
        switch self {
        case .getAllCampaigns:
            return "session"
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
            
        case let .createUser(firstName, lastName, email, password, confirmation, username):
            let encoder = JSONEncoder()
            let body: [String: String] = ["first_name": firstName, "last_name": lastName, "email": email, "password": password, "confirmation": confirmation, "username": username]
            let result = try? encoder.encode(body)
            return result!
        default:
            return nil
        }
    }
}
