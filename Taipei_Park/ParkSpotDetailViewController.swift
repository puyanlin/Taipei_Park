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
    
    private var detailViewController:ParkSpotDetailTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = parkSpot.image, let imageUrl = URL(string: image) {
            imageHeightConstraint.constant = UIScreen.main.bounds.size.width * 0.75
            imgvPark.sd_setImage(with: imageUrl, placeholderImage: nil, options: .highPriority, completed: nil)
        }else{
            imageHeightConstraint.constant = 0
        }
        
//        imageHeightConstraint.constant = 0
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if detailViewController == nil {
            self.addDetailViewController()
        }
    }
    
    private func addDetailViewController(){
        detailViewController = ParkSpotDetailTableViewController(style: .plain)
        detailViewController.parkSpot = parkSpot
        self.addChildViewController(detailViewController)
        
        detailViewController.tableView.frame = self.view.frame
        
        self.view.addSubview(detailViewController.tableView)
        detailViewController.didMove(toParentViewController: self)
        
        detailViewController.tableView.backgroundColor = UIColor.clear
        detailViewController.tableView.translatesAutoresizingMaskIntoConstraints = false
        let left:NSLayoutConstraint = NSLayoutConstraint(item: detailViewController.tableView, attribute: .left, relatedBy:.equal, toItem:self.view, attribute:.left, multiplier:1.0, constant: 0)
        let right:NSLayoutConstraint = NSLayoutConstraint(item: detailViewController.tableView, attribute: .right, relatedBy:.equal, toItem:self.view, attribute:.right, multiplier:1.0, constant: 0)
        let top:NSLayoutConstraint = NSLayoutConstraint(item: detailViewController.tableView, attribute: .top, relatedBy:.equal, toItem:self.view, attribute:.top, multiplier:1.0, constant: 0)
        let bottom:NSLayoutConstraint = NSLayoutConstraint(item: detailViewController.tableView, attribute: .bottom, relatedBy:.equal, toItem:self.view, attribute:.bottom, multiplier:1.0, constant: 0)
        self.view.addConstraints([left,right,top,bottom])
        
        if imageHeightConstraint.constant > 0 {
            let topHeight = self.topLayoutGuide.length
            let transparentHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: imageHeightConstraint.constant - topHeight))
            detailViewController.tableView.tableHeaderView = transparentHeaderView
            transparentHeaderView.backgroundColor = UIColor.clear
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
