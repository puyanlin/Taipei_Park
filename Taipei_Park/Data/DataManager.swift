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
    
    private(set) var groupedParkSpots:[String:[ParkSpot]]?
    
    private init(){}
    
    func requestParkInfo(limit:Int? = nil, offset:Int? = nil, completion:@escaping ((_ groupedParkSpots:[String:[ParkSpot]]?)->Void)){
        
        let parkInfoUrl = "http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=bf073841-c734-49bf-a97f-3757a6013812"
        self.groupedParkSpots = nil
        Alamofire.request(parkInfoUrl).validate().responseJSON { [weak self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let strResults = json["result"]["results"].rawString(), let parkSpots = [ParkSpot](JSONString: strResults), parkSpots.count > 0 {
                    self?.groupedParkSpots = [String:[ParkSpot]]()
                    for s in parkSpots {
                        if var savedSpots = self?.groupedParkSpots?[s.parkName] {
                            savedSpots.append(s)
                            self?.groupedParkSpots?.updateValue(savedSpots, forKey: s.parkName)
                        }else{
                            self?.groupedParkSpots?.updateValue([s], forKey: s.parkName)
                        }
                    }
                }
            case .failure( _): break
            }
            completion(self?.groupedParkSpots)
        }
        
    }
    
//    func relatedSpots(refSpot:ParkSpot, filterRef:Bool = false) -> [ParkSpot]?{
//        if parkSpots != nil {
//            if var cached = cachedRelatedSpot[refSpot.parkName] {
//                if filterRef {
//                    cached.removeObject(refSpot)
//                }
//                return cached
//            }
//            if var filtered = parkSpots?.filter({ (spot) -> Bool in
//                return spot.parkName == refSpot.parkName
//            }) {
//                cachedRelatedSpot.updateValue(filtered, forKey: refSpot.parkName)
//                if filterRef {
//                    filtered.removeObject(refSpot)
//                }
//                return filtered
//            }
//
//        }
//        return nil
//    }
    
    
    
}
