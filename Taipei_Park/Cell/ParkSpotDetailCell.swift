//
//  ParkSpotDetailCell.swift
//  Taipei_Park
//
//  Created by Puyan Lin on 25/01/2018.
//  Copyright © 2018 Puyan. All rights reserved.
//

import UIKit

typealias relatedParkSpotClickedCallback = ((_ spot:ParkSpot) -> Void)

class ParkSpotDetailCell: ParkListCell,UICollectionViewDataSource,UICollectionViewDelegate {

    @IBOutlet weak var lblOpenTime: UILabel!
    @IBOutlet weak var relatedViewContainer: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var callback:relatedParkSpotClickedCallback?
    
    override var parkSpot: ParkSpot!{
        didSet{
            lblOpenTime.text = "開放時間：\(parkSpot.openTime)"
            self.relatedSpots = DataManager.sharedManager.relatedSpots(refSpot: parkSpot, filterRef: true)
            if self.relatedSpots != nil && self.relatedSpots!.count > 0 {
                relatedViewContainer.isHidden = false
                self.collectionView.setContentOffset(CGPoint.zero, animated: false)
                self.collectionView.reloadData()
            }else{
                relatedViewContainer.isHidden = true
            }
        }
    }
    
    private var relatedSpots:[ParkSpot]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "RelatedParkSpotCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RelatedParkSpotCollectionViewCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.relatedSpots == nil ? 0:self.relatedSpots!.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RelatedParkSpotCollectionViewCell", for: indexPath) as! RelatedParkSpotCollectionViewCell
        cell.parkSpot = self.relatedSpots![indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let selectedCell = collectionView.cellForItem(at: indexPath) as! RelatedParkSpotCollectionViewCell
        self.callback?(selectedCell.parkSpot)
    }
    
}
