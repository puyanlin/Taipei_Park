//
//  TaipeiParkExtensions.swift
//  Taipei_Park
//
//  Created by Puyan Lin on 2018/1/25.
//  Copyright © 2018年 Puyan. All rights reserved.
//

import Foundation

public extension Array where Element: Equatable {
    mutating func removeObject(_ object: Element) {
        if let index = self.index(of: object) {
            self.remove(at: index)
        }
    }
    
    mutating func removeObjectsInArray(_ array: [Element]) {
        for object in array {
            self.removeObject(object)
        }
    }
}
