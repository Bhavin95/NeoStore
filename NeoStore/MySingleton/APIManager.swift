//
//  APIManager.swift
//  NeoStore
//
//  Created by webwerks on 18/03/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

final class APIManager {
    
    static let sharedInstance = APIManager()
    private init() {}
    
    let baseURL = "http://staging.php-dev.in:8844/trainingapp/api/"
    
    let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOlsiYXBpdG9rZW5yZXNvdWNlaWRzZWN1cmVkIl0sInVzZXJfbmFtZSI6IkFiZHVsIiwic2NvcGUiOlsicmVhZCIsIndyaXRlIl0sImV4cCI6MTU0OTk3MDIxMSwiYXV0aG9yaXRpZXMiOlsiRV9VU0VSIl0sImp0aSI6ImQ1MWY3MWQwLWExNDctNDRhZC05MmIzLTRlYmJkYmM2MmUzMCIsImNsaWVudF9pZCI6ImVuZ2FnZXByb21vYiJ9.OMNPGsDkRvmq-fzEh9P41jSzkCj12sLiarRvSwsmZMw"
    
    func postData(apiName: String,parameter: [String: Any], onSuccess: @escaping(Data) -> Void, onFailure: @escaping(Error) -> Void) {
        
        let api = baseURL + apiName
        guard let url = URL(string: api) else {
            print("Error: cannot create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue(token, forHTTPHeaderField: "access_token")
        let postData: Data
        do {
            postData = try JSONSerialization.data(withJSONObject: parameter, options: [])
            request.httpBody = postData
        } catch {
            print("Error: cannot create JSON from todo")
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                print("error calling POST on \(apiName)" )
                print(error!)
                onFailure(error!)
                return
            }
            guard let data = data else {
                print("Error: did not receive data")
                onFailure(error!)
                return
            }
            onSuccess(data)
            
            Utilities.getJSON(apiName, data)
        }
        task.resume()
        
    }
    
    func getData(apiName: String,parameter: [String: Any], onSuccess: @escaping(Data) -> Void, onFailure: @escaping(Error) -> Void) {
        
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
        request.addValue(token, forHTTPHeaderField: "access_token")
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                print("error calling POST on \(apiName)" )
                print(error!)
                onFailure(error!)
                return
            }
            guard let data = data else {
                print("Error: did not receive data")
                onFailure(error!)
                return
            }
            onSuccess(data)
            
            Utilities.getJSON(apiName, data)
        }
        task.resume()
    }
    
}
