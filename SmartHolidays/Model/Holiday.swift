//
//  Holiday.swift
//  SmartHolidays
//
//  Created by 1 on 9/5/19.
//  Copyright © 2019 1. All rights reserved.
//

import Foundation
import ObjectMapper

struct Holiday: Mappable {
    
    var counties : AnyObject!
    var countryCode : String!
    var date : String!
    var fixed : Bool!
    var global : Bool!
    var launchYear : AnyObject!
    var localName : String!
    var name : String!
    var type : String!
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        counties <- map["countries"]
        countryCode <- map["countryCode"]
        date <- map["date"]
        fixed <- map["fixed"]
        global <- map["global"]
        launchYear <- map["launchYear"]
        localName <- map["localName"]
        name <- map["name"]
        type <- map["type"]
    }
    
    
}
