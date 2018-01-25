//
//  ParkListCell.swift
//  Taipei_Park
//
//  Created by Puyan Lin on 2018/1/24.
//  Copyright © 2018年 Puyan. All rights reserved.
//

import UIKit
import SDWebImage

let defaultImage = UIImage(named: "park_default")

class ParkListCell: UITableViewCell {

    var parkSpot:ParkSpot! {
        didSet{
            lblParkName.text = parkSpot.parkName
            lblName.text = parkSpot.name
            lblIntro.text = parkSpot.introduction
            
            if imgvPark != nil {
                if let image = parkSpot.image, let imageUrl = URL(string: image) {
                    imgvPark.sd_setImage(with: imageUrl, placeholderImage: defaultImage, options: .continueInBackground, completed: nil)
                }else{
                    imgvPark.image = defaultImage
                }
            }
        }
    }
    
    @IBOutlet weak var lblParkName: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblIntro: UILabel!
    @IBOutlet weak var imgvPark: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
