//
//  ParkListCell.swift
//  Taipei_Park
//
//  Created by Puyan Lin on 2018/1/24.
//  Copyright © 2018年 Puyan. All rights reserved.
//

import UIKit
import SDWebImage

class ParkListCell: BaseParkSpotCell {
    let defaultImage = UIImage(named: "park_default")
    override var parkSpot:ParkSpot! {
        didSet{
            if imgvPark != nil {
                if let image = parkSpot.image, let imageUrl = URL(string: image) {
                    imgvPark.sd_setImage(with: imageUrl, placeholderImage: defaultImage, options: .continueInBackground, completed: nil)
                }else{
                    imgvPark.image = defaultImage
                }
            }
        }
    }
    
    @IBOutlet weak var imgvPark: UIImageView!
    
}
