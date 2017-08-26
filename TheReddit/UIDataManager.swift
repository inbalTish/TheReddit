//
//  UIDataManager.swift
//  TheReddit
//
//  Created by Inbal Tish on 25/08/2017.
//  Copyright © 2017 Inbal Tish. All rights reserved.
//

import Foundation
import UIKit

class UIDataManager {
    
    static let sharedInstance = UIDataManager()
    
    //MARK:- Shared Variables
    var favorites = [Thing]()
    var notif_dataLoadingPoint = "reachedDataLoadingPoint"
    
    
    //MARK:- Shard functions
    func postNotification(_ name: String, object: AnyObject?) {
        DispatchQueue.main.async {
            let notificationCenter = NotificationCenter.default
            notificationCenter.post(name: Notification.Name(rawValue: name), object: object)
        }
    }
    
    
}
