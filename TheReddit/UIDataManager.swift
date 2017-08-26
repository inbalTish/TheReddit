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
    
    
}
