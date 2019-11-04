//
//  APIClient.swift
//  SmartHolidays
//
//  Created by 1 on 9/5/19.
//  Copyright © 2019 1. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class APIClient: NSObject {
    
    let BASE_URL: URL
    
    static let shared: APIClient = { APIClient(baseUrl: SettingManager.shared.apiURL) }()
    
    required init(baseUrl: String){
        self.BASE_URL = URL(string: baseUrl)!
    }
    
    func getArray<T: BaseMappable> (_ urlString:String, success: @escaping (Int, [T]?) -> (), failure: @escaping (Int) -> ()) {
        
        let url = URL(string: urlString, relativeTo: self.BASE_URL as URL?)
        let urlString = url?.absoluteString
        
        Alamofire.request(urlString!, method: .get, encoding: JSONEncoding.default).responseArray(completionHandler: { (response: DataResponse<[T]>) in
            
            if (response.response != nil && response.result.value != nil && (response.response?.statusCode == 200 || response.response?.statusCode == 201)){
                success(response.response!.statusCode, response.result.value)
            }else if (response.response?.statusCode == 401){
                failure((response.response != nil ? (response.response?.statusCode)! : 400))
            }else{
                failure((response.response != nil ? (response.response?.statusCode)! : 400))
            }
        })
    }
    
}
