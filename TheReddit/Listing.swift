//
//  Listing.swift
//  TheReddit
//
//  Created by Inbal Tish on 25/08/2017.
//  Copyright © 2017 Inbal Tish. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Listing {
    var kind: String?
    var modhash: String?
    var children: [Thing]
    var after: String?
    var before: String?
    

    init(json: JSON) {
        kind = json["kind"].string
        modhash = json["data"]["modhash"].string
        after = json["data"]["after"].string
        before = json["data"]["before"].string
        
        children = [Thing]()
        let childrenJson = json["data"]["children"]
        for (_, subjson):(String, JSON) in childrenJson {
            let thing = Thing(json: subjson)
            children.append(thing)
        }
    }
}
