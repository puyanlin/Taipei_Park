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

let KEY_CACHED_PARK_SPOTS:String = "KEY_CACHED_PARK_SPOTS"
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
    
    func requestParkInfo(completion:@escaping ((_ groupedParkSpots:[String:[ParkSpot]]?, _ success:Bool)->Void)){
        
        let parkInfoUrl = "http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=bf073841-c734-49bf-a97f-3757a6013812"
        self.groupedParkSpots = nil
        Alamofire.request(parkInfoUrl).validate().responseJSON { response in
            var success = false
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let strResults = json["result"]["results"].rawString()
                success = self.parseResults(rawString: strResults)
                if success {
                    UserDefaults.standard.set(strResults, forKey: KEY_CACHED_PARK_SPOTS)
                    UserDefaults.standard.synchronize()
                }
            case .failure( _): break
            }
            if !success {
                self.parseResults(rawString: UserDefaults.standard.string(forKey: KEY_CACHED_PARK_SPOTS))
            }
            completion(self.groupedParkSpots, success)
        }
        
    }
    
    @discardableResult func parseResults(rawString:String?) -> Bool {
        if let strResults = rawString, let parkSpots = [ParkSpot](JSONString: strResults), parkSpots.count > 0 {
            self.groupedParkSpots = [String:[ParkSpot]]()
            for s in parkSpots {
                if var savedSpots = self.groupedParkSpots?[s.parkName] {
                    savedSpots.append(s)
                    self.groupedParkSpots?.updateValue(savedSpots, forKey: s.parkName)
                }else{
                    self.groupedParkSpots?.updateValue([s], forKey: s.parkName)
                }
            }
            return true
        }
        return false
    }
    
    
    func relatedSpots(refSpot:ParkSpot, filterRef:Bool = false) -> [ParkSpot]?{
        if groupedParkSpots != nil {
            if var related = groupedParkSpots![refSpot.parkName] {
                if filterRef {
                    related.removeObject(refSpot)
                }
                return related
            }
        }
        return nil
    }
}
