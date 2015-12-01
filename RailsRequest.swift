//
//  RailsRequest.swift
//  RR
//
//  Created by Susanne Burnham on 11/5/15.
//  Copyright © 2015 Susanne Kasahara. All rights reserved.
//

// making a singleton to access a token

import UIKit

let _rr = RailsRequest()

let _d = NSUserDefaults.standardUserDefaults()

class RailsRequest: NSObject {
    
    
    
    class func session() -> RailsRequest { return _rr }
    
    var token: String? {
        
        get { return _d.objectForKey("token") as? String }
        set { _d.setObject(newValue, forKey: "token") }
        
        
    }
    
    //// CHANGE OUT WITH TEAM 5
    /// need methods and parameters for request, endpoint type and parameters
    
    

      private let base = "https://mysterious-fjord-1759.herokuapp.com"
    
    func loginWithUsername(username: String, andPassword password: String, completion: (loggedIn: Bool) -> ()) {
        
        var info = RequestInfo()
        
        info.endpoint = "/login"
        info.method = .POST
        info.parameters = [
            
            "username" : username,
            "password" : password
        ]
        
        requestWithInfo(info) { (returnedInfo) -> () in
            
            print(returnedInfo)
            
            if let user = returnedInfo?["user"] as? [String:AnyObject] {
                
                if let key = user["access_token"] as? String {
                    
                    self.token = key
                    
                    print(self.token)
                    
                    completion(loggedIn: true)
                } else {
                    
                    completion(loggedIn: false)
                    
                }
                
                
            }else {
                
                completion(loggedIn: false)
                
            }
            
        }
        
    }
    
    func registerWithUsername(username: String, andPassword password: String, email: String, completion: (registered: Bool) -> ()) {
        
        
        var info = RequestInfo()
    
        info.endpoint = "/signup"
        info.method = .POST
        info.parameters = [
            
            
            "username" : username,
            "email" : email,
            "password" : password
            
        ]
        
        requestWithInfo(info) { (returnedInfo) -> () in
            
            
            print(returnedInfo)
            
            
            // here we grab the access token & user id in cards table view controller ,
            
            if let user = returnedInfo?["user"] as? [String:AnyObject] {
                
                if let key = user["access_token"] as? String {
                    
                    self.token = key
                    
                    print(self.token)
                
                    
                    completion(registered: true)
                } else {
                    
                    completion(registered: false)
                    
                }
                
                
            }else {
                
                completion(registered: false)
                
            }

            
            
        }
        
    }
    


    // info:AnyObhect may not be the info need to casr (info: ANyObject cast for
    func requestWithInfo(info: RequestInfo, completion: (returnedInfo: AnyObject?) -> ()) {
        
        var fullURLString = base + info.endpoint
        
        for (i,(k,v)) in info.query.enumerate() {
            
            if i == 0 { fullURLString += "?" } else { fullURLString += "&" }
            
            fullURLString += "\(k)=\(v)"

        }
    

        guard let url = NSURL(string: fullURLString) else { return } // add run completion with fail
        
        let request = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = info.method.rawValue
        
        //add token if we have one
        
        if let token = token {
            
            // can add token when they give it to you
            request.setValue(token, forHTTPHeaderField: "Access-Token")
            
            print(token)
            
        }
        
        // add parameters to body 1. checked info parameters, turns to request data and set value for headerfield JSON string remove post data and pass in request data if weird characters show up
        
        if info.parameters.count > 0 {
            
            if let requestData = try? NSJSONSerialization.dataWithJSONObject(info.parameters, options: .PrettyPrinted) {
                
                if let jsonString = NSString(data: requestData, encoding: NSUTF8StringEncoding) {
                    
                    request.setValue("\(jsonString.length)", forHTTPHeaderField: "Content-Length")
                    
                    let postData = jsonString.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
                    
                    request.HTTPBody = postData
                    
                    
                }
                
            }
            
            
        }
        
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // creates a task from request - based on network connectivity
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            
            print(data)
            
            // work with data returned
            
            if let data = data {
                
                // have data
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    if let returnedInfo = try? NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) {
                        
                        completion(returnedInfo: returnedInfo)
                        
                    } else {
                        
                        completion(returnedInfo: nil)
                        
                    }
                    
                })
                
            } else {
                
                // no data: check for error and return alert from
            }
        }
        task.resume()
        
    }
    
}

struct RequestInfo {
    
    enum MethodType: String {
        
        case POST, GET, DELETE
    }
    
    var endpoint: String!
    var method: MethodType = .GET
    var parameters: [String:AnyObject] = [:]
    var query: [String:AnyObject] = [:]
    
}


