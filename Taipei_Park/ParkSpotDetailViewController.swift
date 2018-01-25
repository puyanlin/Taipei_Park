//
//  ParkSpotDetailViewController.swift
//  Taipei_Park
//
//  Created by Puyan Lin on 2018/1/25.
//  Copyright © 2018年 Puyan. All rights reserved.
//

import UIKit
import SDWebImage

class ParkSpotDetailViewController: UIViewController {

    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imgvPark: UIImageView!
    
    var parkSpot:ParkSpot!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let image = parkSpot.image, let imageUrl = URL(string: image) {
            
             imgvPark.sd_setImage(with: imageUrl, placeholderImage: nil, options: .highPriority, completed: nil)
            
        }else{
            imageHeightConstraint.constant = 0
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
