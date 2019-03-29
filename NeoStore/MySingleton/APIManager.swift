//
//  APIManager.swift
//  NeoStore
//
//  Created by webwerks on 18/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import Foundation

final class APIManager {
    
    static let sharedInstance = APIManager()
    private init() {}
    
    let baseURL = "http://staging.php-dev.in:8844/trainingapp/api/"
    
//    let token = "5c90c6cfd0409"
    var passwordItems = [KeychainPasswordItem]()
    
    func postData(apiName: String,parameter: [String: Any], onSuccess: @escaping(Data) -> Void, onFailure: @escaping(String) -> Void) {
        
        let api = baseURL + apiName
        guard let url = URL(string: api) else {
            print("Error: cannot create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue(APIConstants.token, forHTTPHeaderField: "access_token")
        
        let postString = parameter.queryString
        let postData = postString.data(using: .utf8)
        request.httpBody = postData

        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                onFailure("error calling POST on \(apiName)")
                return
            }
            guard let data = data else {
                onFailure("Error: did not receive data")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                onFailure("Error: did not http response")
                return
            }
            
            if httpResponse.statusCode == APIConstants.statusCode {
                onSuccess(data)
            } else {
                let resultDict = Utilities.getJSON(apiName, data)
                guard let userMessage = resultDict["user_msg"] as? String else {
                    return
                }
                onFailure(userMessage)
            }
        }
        task.resume()
        
    }
    
    func getData(apiName: String,parameter: [String: Any], onSuccess: @escaping(Data) -> Void, onFailure: @escaping(String) -> Void) {
        
        let api = baseURL + apiName
        guard let url = URL(string: api) else {
            print("Error: cannot create URL")
            return
        }
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        let queryItems = parameter.map{
            return URLQueryItem(name: "\($0)", value: "\($1)")
        }
        
        urlComponents?.queryItems = queryItems
        
        var request = URLRequest(url: (urlComponents?.url)!)
        request.httpMethod = "GET"
        request.addValue(APIConstants.token, forHTTPHeaderField: "access_token")
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                onFailure("error calling POST on \(apiName)")
                return
            }
            guard let data = data else {
                onFailure("Error: did not receive data")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                onFailure("Error: did not http response")
                return
            }
            if httpResponse.statusCode == APIConstants.statusCode {
                onSuccess(data)
            } else {
                let resultDict = Utilities.getJSON(apiName, data)
                guard let userMessage = resultDict["user_msg"] as? String else {
                    return
                }
                onFailure(userMessage)
            }
            
        }
        task.resume()
    }
    
}
