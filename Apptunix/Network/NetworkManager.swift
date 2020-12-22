//
//  NetworkManager.swift
//  Apptunix
//
//  Created by Arpit Garg on 18/12/20.
//  Copyright © 2020 Arpit Garg. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias ServiceResponse = (JSON?, Error?) -> Void

enum RequestType: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class NetworkManager: NSObject {
    

    let baseURL: String
    let auth:String
    
    private static var sharedNetworkManager: NetworkManager = {
        let networkManager = NetworkManager(AppCredentials.BASEURL, AppCredentials.AUTH)
        return networkManager
    }()
    
    private init(_ baseURL: String,_ auth: String) {
        self.baseURL = baseURL
        self.auth = auth
    }
    
    class func shared() -> NetworkManager {
        return sharedNetworkManager
    }
    
    func fetchData(verb: RequestType, dict: [String: Any], _ completion: @escaping ServiceResponse) {
//        SVProgressHUD.show(withStatus: "loading".localized)
        let api = AppCredentials.BASEURL + "/v1/restaurant/"
        var request = URLRequest(url: URL(string: api)!)
        request.httpMethod = verb.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(auth, forHTTPHeaderField: "Authorization")
        if verb == .post  ||  verb == .put {
            if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) {
                request.httpBody = jsonData
            }
        }
        
        NetworkManager.sharedNetworkManager.requestForData(request: request) { (responseObject: JSON?, error: Error?) in
            if let error =  error {
//                SVProgressHUD.dismiss()
                completion( nil, error)
            } else {
//                SVProgressHUD.dismiss()
                completion(responseObject, nil)
            }
        }
        
    }
    
    func requestForData (request: URLRequest, _ completion: @escaping ServiceResponse) {
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 120
        manager.request(request).responseJSON { (response) in
            switch response.result {
            case .success:
                if let jsonData  = try? JSON.init(data: response.data!) {
                    completion(jsonData["data"], nil)
                }
                
            case .failure(let error):
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    print("Data: \(utf8Text)")
                }
                completion( nil, error as NSError)
            }
        }
    }
    
}
