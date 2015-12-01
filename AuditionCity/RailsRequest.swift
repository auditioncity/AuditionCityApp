//  RailsRequest.swift
//  Created by Paul Vagner on 11/5/15.
//  Copyright © 2015 Paul Vagner. All rights reserved.
// THIS WILL FUNCTION WITH ALL REQUESTS

import UIKit

private let _rr = RailsRequest()

private let _d = NSUserDefaults.standardUserDefaults()
/// Creates a "RailsRequest" class of type NSObject
class RailsRequest: NSObject {
    /**
     Creates a class function for the "RailsRequest"class
     
     - returns: the "RailsRequest"
     */
    class func session() -> RailsRequest { return _rr }
    
 /// The token captured after login/register used to make authenticated API calls.
    
    var token: String? {
        
        get { return _d.objectForKey("token") as? String }
        set { _d.setObject(newValue, forKey: "token") }
        
    }
        //will need out own server info
   
    /// The base URL used when making API call.
    private let APIbaseURL = "https://guarded-ridge-7410.herokuapp.com"
    
    /**
     This method will try to login a user with credentials below.
     
     - parameter username: The name used when registering.
     - parameter password: The password used when registering.
     */
    func loginWithUsername(username: String, andPassword password: String) {
        /// creates a changeable variable of "info" and sets it to "RailsRequest"
        var info = RequestInfo()

        info.endpoint = "/users/login"
        
        info.method = .POST
        
        info.parameters = [
        
            "username" : username,
            "password" : password
            
        ]

       requiredWithInfo(info) { (returnedInfo) -> () in
        
        if let user = returnedInfo?["user"] as? [String:AnyObject] {
            
            if let key = user["access_token"] as? String {

                self.token = key
            
                }
            }
        
        
        if let errors = returnedInfo?["errors"] as? [String] {
            //loops through errors
            }
    
        }
    
    }
    
    /**
     Makes a generic request to the API, configured by the info parameter.
     
     - parameter info:       Used to configure the API request.
     - parameter completion: A completion block that may be calld with an optional object.
        The object could be an Array or Dictionary, YOU MUST handle the type within the completion block.
     */
    func requiredWithInfo(info: RequestInfo, completion: (returnedInfo: AnyObject?) -> ()) {
        let fullURLString = APIbaseURL + info.endpoint
        guard let url = NSURL(string: fullURLString) else { return } //add run completion with fail
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = info.method.rawValue
        //add token if we have one
        if let token = token {
        request.setValue(token, forHTTPHeaderField: "Authorization")
            if let requestData = try? NSJSONSerialization.dataWithJSONObject(info.parameters, options: .PrettyPrinted) {
                if let jsonString = NSString(data: requestData, encoding: NSUTF8StringEncoding) {
                    request.setValue("\(jsonString.length)", forHTTPHeaderField: "Content-Length")
                    let postData = jsonString.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
                    request.HTTPBody = postData
                }
            }
            request.setValue("application/json", forHTTPHeaderField: "Content_Type")
            //here we grab the access token & user id
        }
        // add parameters to body
        //creates a task from request
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            //work with the data returned
            if let data = data {
                //have data
                if let returnedInfo = try? NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) {
                    completion(returnedInfo: returnedInfo)
                }
            } else {
                //no data: check if error is not nil
            }
        }
        //runs the task (aka: makes the request call)
        task.resume()
    }
}
/**
 * A type used to collect information to build an API call.
 */
struct RequestInfo {
    
    enum MethodType: String {
        
        case POST, GET, DELETE
    }
    /// The part of the URL added to the base to make a specific API call.
    var endpoint: String!
 
    /// The method type (GET, POST, DELETE) used to madifying the API call.
    var method: MethodType = .GET
 
    /// Parameters that are required/optional to be added to the API call.
    var parameters: [String:AnyObject] = [:]
    
}


