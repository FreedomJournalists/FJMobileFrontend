//
//  Routes.swift
//  fj-mobile
//
//  Created by Tony Cioara on 3/19/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation
import KeychainSwift

enum ImageUploadRoute {
    case campaignUpload(id: Int)
    case userUpload(id: Int)
    
    func Headers() -> [String: String] {
        let keychain = KeychainSwift()
        let token = keychain.get("fjToken")
        let authorization = "Bearer " + token!
        return ["Content-Type": "application/json", "Authorization":authorization]
    }
    
    func Path() -> String {
        switch self {
        case let .userUpload(id):
            return "users/\(id)"
        case let .campaignUpload(id):
            return "campaigns/\(id)"
        }
    }
    
    func name() -> String {
        switch self {
        case .userUpload:
            return "profile_image_file"
        case .campaignUpload:
            return "image_file"
        }
    }
    
    func fileName() -> String {
        switch self {
        case let .userUpload(id):
            return "User\(String(describing: id))Image"
        case let .campaignUpload(id):
            return "Campaign\(String(describing: id))Image"
        }
    }
}
        
enum Route {
    
    case postCampaign(title: String, description: String, goal: Int)
    case getAllCampaigns
    case login(email: String, password: String)
    case signUp(email: String, firstName: String, lastName: String, nickname: String, password: String)
    case getCurrentUser
    
    func queryParameters() -> [String : String] {
        switch self {
        case let .login(email, password):
            return ["email": email, "password": password]
        default:
            return [:]
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
        case .getCurrentUser:
            return "GET"
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
        case .getCurrentUser:
            return "me"
        }
    }
    
    func body() -> Data? {
        switch self {
        case let .signUp(email, firstName, lastName, nickname, password):
            let encoder = JSONEncoder()
            let body: [String: String] = ["email": email, "first_name": firstName, "last_name": lastName, "nickname": nickname, "password": password]
            let result = try? encoder.encode(body)
            return result!
            
        case let .postCampaign(title, description, goal):
            let body: [String: Any] = ["title": title, "description": description, "goal": goal]
            let result = try! JSONSerialization.data(withJSONObject: body, options: [])
            return result
            
        default:
            return nil
        }
    }
    
    func headers() -> [String: String] {
        switch self {
        case .login, .signUp:
            return ["Content-Type": "application/json"]
        default:
            let keychain = KeychainSwift()
            let token = keychain.get("fjToken")
            let authorization = "Bearer " + token!
            return ["Content-Type": "application/json", "Authorization":authorization]
        }
    }
}

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
