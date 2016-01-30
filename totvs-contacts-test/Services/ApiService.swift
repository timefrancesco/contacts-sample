//
//  ApiService.swift
//  totvs-contacts-test
//
//  Created by Francesco Pretelli on 30/01/16.
//  Copyright © 2016 Francesco Pretelli. All rights reserved.
//

import Foundation

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class APIservice {
    static let sharedInstance = APIservice() //singleton lazy initialization, apple supports it sice swift 1.2
    private init() {} //This prevents others from using the default '()' initializer for this class.
    
    let ENDPOINT = "http://shy-pine-8960.getsandbox.com/users"
    
    func getUsers(callback: (data: [User]) -> Void ){
        sendRequestArray(User.self, endpoint: ENDPOINT, method: Alamofire.Method.GET){ (result:[User]?) in
            result == nil ? callback(data:[User]()) :  callback(data: result!)
        }
    }
    
    func sendRequestArray<T: Mappable>(obj: T.Type, endpoint:String, method:Alamofire.Method, callback: (result: [T]?) -> Void ) {
        Alamofire.request(method, endpoint).responseArray { (response: Response<[T], NSError>) in
            guard response.result.error == nil
                else {
                    // got an error in getting the data, need to handle it
                    print("error in API array request -> " + String(response.result.error!))
                    callback(result: nil)
                    return
            }
            callback (result: response.result.value!)
        }
    }
}