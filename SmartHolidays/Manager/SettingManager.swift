//
//  SettingManager.swift
//  SmartHolidays
//
//  Created by 1 on 9/6/19.
//  Copyright © 2019 1. All rights reserved.
//

import Foundation

class SettingManager: NSObject {
    
    static let shared: SettingManager = { SettingManager() }()
    lazy var apiURL: String = {
        return "https://date.nager.at/api/v2/publicholidays/"
    }()
}
