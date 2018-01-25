//
//  ParkSpotDetailCell.swift
//  Taipei_Park
//
//  Created by Puyan Lin on 25/01/2018.
//  Copyright © 2018 Puyan. All rights reserved.
//

import UIKit

class ParkSpotDetailCell: ParkListCell {

    @IBOutlet weak var lblOpenTime: UILabel!
    
    override var parkSpot: ParkSpot!{
        didSet{
            lblOpenTime.text = "開放時間：\(parkSpot.openTime)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
