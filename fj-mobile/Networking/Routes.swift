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
    case getUserCampaigns
    case getUserPledges
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
    case getCampaignPledges
    //POST
    case postCampaign(title: String, description: String, goal: String)
    //UPDATE
    //There should be one for when you create a user
    //DELETE
    case deleteCampaign
    
    ////////////////////////////////////////////////
    //Routes Pledges Related
    //GET
    //POST
    case postPledge
    //DELETE
    case deletePledge
    
    func method() -> String {
        switch self {
    case .getUser, .getUserCampaigns, .getAllCampaigns, .getCampaign, .getCampaignPledges, .getUserPledges:
            return "GET"
        case .loginUser, .createUser, .postCampaign, .postPledge:
            return "POST"
        case .logoutUser, .deleteUser, .deleteCampaign, .deletePledge:
            return "DELETE"
        }
    }
    
    func path() -> String {
        switch self {
        case .getUser, .logoutUser, .getUserPledges:
            return "session"
    case .getUserCampaigns, .getAllCampaigns, .getCampaign, .getCampaignPledges:
            return "campaign"
        case .loginUser:
            return "get token"
        case .createUser:
            return "new user"
        case .postCampaign:
            return "new campaign"
        case .postPledge:
            return "new pledge"
        case .deleteUser:
            return ""
        case .deleteCampaign:
            return ""
        case .deletePledge:
            return ""
        }
    }
    
    func body() -> Data? {
        switch self {
        case let .createUser(email, firstName, lastName, nickname, password):
            let user = User(email: email, firstName: firstName, lastName: lastName, nickname: nickname, password: password)
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
