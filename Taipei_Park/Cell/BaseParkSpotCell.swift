//
//  BaseParkSpotCell.swift
//  Taipei_Park
//
//  Created by Puyan Lin on 2018/1/25.
//  Copyright © 2018年 Puyan. All rights reserved.
//

import UIKit

class BaseParkSpotCell: UITableViewCell {
    var parkSpot:ParkSpot! {
        didSet{
            lblParkName.text = parkSpot.parkName
            lblName.text = parkSpot.name
            lblIntro.text = parkSpot.introduction
        }
    }
    
    @IBOutlet weak var lblParkName: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblIntro: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
