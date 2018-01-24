//
//  DataManager.swift
//  Taipei_Park
//
//  Created by Puyan Lin on 2018/1/24.
//  Copyright © 2018年 Puyan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DataManager {
    private static var instance:DataManager!
    
    static var sharedManager:DataManager {
        get{
            if instance == nil {
                instance = DataManager()
            }
            return instance
        }
    }
    
    private(set) var parkSpots:[ParkSpot]?
    
    private init(){}
    
    func requestParkInfo(limit:Int? = nil, offset:Int? = nil, completion:@escaping ((_ success:Bool)->Void)){
        
        let parkInfoUrl = "http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=bf073841-c734-49bf-a97f-3757a6013812"
        
        Alamofire.request(parkInfoUrl).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let strResults = json["result"]["results"].rawString() {
                    self.parkSpots = [ParkSpot](JSONString: strResults)
                    completion(self.parkSpots != nil && self.parkSpots!.count > 0)
                    return
                }
                completion(false)
            case .failure( _):
                completion(false)
            }
        }
        
    }
        
    
    
}
