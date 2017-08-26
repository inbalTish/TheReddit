//
//  NotificationCenterProtocol.swift
//  TheReddit
//
//  Created by Inbal Tish on 26/08/2017.
//  Copyright © 2017 Inbal Tish. All rights reserved.
//

import Foundation

protocol NotificationCenterProtocol {
    
    func postNotificationName(name: String, object: AnyObject?)
    
}

extension NotificationCenterProtocol {
    
    func postNotificationName(name: String, object: AnyObject?) {
        DispatchQueue.main.async {
            let notificationCenter = NotificationCenter.default
            notificationCenter.post(name: Notification.Name(rawValue: name), object: object)
        }
    }
}
