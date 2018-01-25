//
//  ParkSpot.swift
//  Taipei_Park
//
//  Created by Puyan Lin on 2018/1/24.
//  Copyright © 2018年 Puyan. All rights reserved.
//

import Foundation
import ObjectMapper

class ParkSpot:Mappable, Equatable{
    static func ==(lhs: ParkSpot, rhs: ParkSpot) -> Bool {
        return lhs.id == rhs.id
    }
    
    private(set) var parkName:String!
    private(set) var name:String!
    private(set) var openTime:String = "沒有資料"
    private(set) var image:String?
    private(set) var introduction:String!
    
    private(set) var id:String!
    
    //no use field
    private(set) var yearBuilt:String?
    
    required init?(map: Map) {}

    func mapping(map: Map) {
        id <- map["_id"]
        
        parkName <- map["ParkName"]
        name <- map["Name"]
        openTime <- map["OpenTime"]
        image <- map["Image"]
        introduction <- map["Introduction"]
        
        yearBuilt <- map["YearBuilt"]
    }
}
