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
    case deleteUser(user_id: Int)
    
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
            return "get_token"
        case .createUser:
            return "new_user"
        case .postCampaign:
            return "new_campaign"
        case .postPledge:
            return "new_pledge"
        case .deleteUser:
            return "deleted_user"
        case .deleteCampaign:
            return "deleted_campaign"
        case .deletePledge:
            return "deleted_pledge"
        }
    }
    
    func body() -> Data? {
        switch self {
        case let .loginUser(email,password):
            let encoder = JSONEncoder()
            let body: [String: String] = ["email": email, "password": password]
            let result = try? encoder.encode(body)
            return result!
            
        case let .createUser(email, first_name, last_name, nickname, password):
            let encoder = JSONEncoder()
            let body: [String: String] = ["email": email, "first_name": first_name, "last_name": last_name, "nickname": nickname, "password": password]
            let result = try? encoder.encode(body)
            return result!
            
        case let .deleteUser(_:user_id):
            let body: [String: Int] = ["user_id": user_id]
            let result = try? JSONSerialization.data(withJSONObject: body, options: [])
            return result!
            
        default:
            return nil
        }
    }
    
    func Parameters() -> [String: String] {
        switch self {
        case let .getUser(nickname):
            return ["nickname": nickname]
        case .getUserCampaigns:
            <#code#>
        case .getUserPledges:
            <#code#>
        case .getAllCampaigns:
            <#code#>
        case .getCampaign:
            <#code#>
        case .getCampaignPledges:
            <#code#>

        default:
            return [:]
        }
    }
    
    func headers() -> [String: String] {
        switch self {
        case .loginUser, .createUser:
            return ["Content-Type": "application/json"]
        default:
            let keychain = KeychainSwift()
            let token = keychain.get("token")
            let email = keychain.get("email")
            return ["Content-Type": "application/json",
                    "x-User-Token": "\(token!)",
                    "x-User-Email": email!]
        }
    }
}
