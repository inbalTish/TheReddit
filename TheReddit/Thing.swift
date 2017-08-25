//
//  Thing.swift
//  TheReddit
//
//  Created by Inbal Tish on 25/08/2017.
//  Copyright © 2017 Inbal Tish. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Thing {
    var kind: String?
    var title: String?
    var permalink: String?
    var thumbnail: String?
    var thumbnail_width: Int?
    
    init(json: JSON) {
        kind = json["kind"].string
        title = json["data"]["title"].string
        permalink = json["data"]["permalink"].string
        thumbnail = json["data"]["thumbnail"].string
        thumbnail_width = json["data"]["thumbnail_width"].int
    }
}
