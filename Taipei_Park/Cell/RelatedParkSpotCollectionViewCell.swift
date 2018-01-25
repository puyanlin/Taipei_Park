//
//  RelatedParkSpotCollectionViewCell.swift
//  Taipei_Park
//
//  Created by Puyan Lin on 2018/1/25.
//  Copyright © 2018年 Puyan. All rights reserved.
//

import UIKit


class RelatedParkSpotCollectionViewCell: UICollectionViewCell {
    let defaultImage = UIImage(named: "park_default")
    
    @IBOutlet weak var imgvSpot: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    var parkSpot: ParkSpot!{
        didSet{
            lblName.text = parkSpot.name
            
            if let image = parkSpot.image, let imageUrl = URL(string: image) {
                imgvSpot.sd_setImage(with: imageUrl, placeholderImage: defaultImage, options: .highPriority, completed: nil)
            }else{
                imgvSpot.image = defaultImage
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
