//
//  File.swift
//  MyTravel
//
//  Created by Paul Vagner on 11/14/15.
//  Copyright © 2015 Anjel Villafranco. All rights reserved.
//

import Foundation
import UIKit

private let singleton = LogData()

class LogData: NSObject {
    
    class func logSession() -> LogData { return singleton }
    
    var users: [[String:AnyObject]] = []
    
    var starred: [[String:AnyObject]] {
        
        return users.filter({ (user) -> Bool in
            
            return user["actor"]?["decision_callback"] as? Int ?? 0 == 1
            
        })
        
    }
    
}