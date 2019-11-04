//
//  HolidayService.swift
//  
//
//  Created by 1 on 9/5/19.
//

import Foundation
import Alamofire

class HolidayService: NSObject {
   
//    let BASE_URL = "https://date.nager.at/api/v2/publicholidays/"
    static let shared: HolidayService = { HolidayService() }()
    
    func getHolidays(_ year: Int, _ countryCode: String, success: @escaping (Int, [Holiday]) -> (), failure: @escaping (Int) -> ()) {
        APIClient.shared.getArray("\(year)/\(countryCode)", success: { (code, holiday) in
            success(code, holiday!)
        }) { (code) in
            failure(code)
        }
        
    }
    
  
}
