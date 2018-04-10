//
//  Networking.swift
//  fj-mobile
//
//  Created by Tony Cioara on 3/19/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation

class Network {
    static let instance = Network()
    
    let baseURL = "https://freedom-journalism.herokuapp.com/"
    let session = URLSession.shared
    
    func fetch(route: Route, completion: @escaping (Data, HTTPURLResponse) -> Void) {
        var fullPath = baseURL + route.path()
        if route.queryParameters() != [:] {
            fullPath.append(contentsOf: "?" + route.queryParameters().queryParameters)
        }
        let pathURL = URL(string: fullPath)
        var request = URLRequest(url: pathURL!)
        
        request.httpMethod = route.method()
        request.allHTTPHeaderFields = route.headers()
        request.httpBody = route.body()
        
        
        session.dataTask(with: request) { (data, resp, err) in
//                        print("DATA:" + String(describing: data) + "RESP:" + String(describing: resp) + "ERR:" + String(describing: err))
            if let data = data, let resp = resp {
                completion(data, resp as! HTTPURLResponse)
                
            }
            
            }.resume()
    }
}

extension URL {
    func appendingQueryParameters(_ parametersDictionary : Dictionary<String, String>) -> URL {
        let URLString : String = String(format: "%@?%@", self.absoluteString, parametersDictionary.queryParameters)
        //
        return URL(string: URLString)!
    }
    // This is formatting the query parameters with an ascii table reference therefore we can be returned a json file
}

protocol URLQueryParameterStringConvertible {
    var queryParameters: String {get}
}

extension Dictionary : URLQueryParameterStringConvertible {
    /**
     This computed property returns a query parameters string from the given NSDictionary. For
     example, if the input is @{@"day":@"Tuesday", @"month":@"January"}, the output
     string will be @"day=Tuesday&month=January".
     @return The computed parameters string.
     */
    var queryParameters: String {
        var parts: [String] = []
        for (key, value) in self {
            let part = String(format: "%@=%@",
                              String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                              String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            parts.append(part as String)
        }
        return parts.joined(separator: "&")
    }
}
