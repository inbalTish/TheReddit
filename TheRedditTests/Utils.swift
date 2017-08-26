//
//  Utils.swift
//  TheReddit
//
//  Created by Inbal Tish on 26/08/2017.
//  Copyright © 2017 Inbal Tish. All rights reserved.
//

import Foundation
import SwiftyJSON

class Utils {
    
    func getMockJson(fileName: String) -> JSON? {
        if let path = Bundle(for: type(of: self)).path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
                    print("jsonData:\(jsonObj)")
                    return jsonObj
                } else {
                    print("Could not get json from file, make sure that file contains valid json.")
                }
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }
        return nil
    }
}
