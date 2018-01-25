//
//  ParkTableViewController.swift
//  Taipei_Park
//
//  Created by Puyan Lin on 2018/1/24.
//  Copyright © 2018年 Puyan. All rights reserved.
//

import UIKit
import SDWebImage

class ParkTableViewController: UITableViewController {

    private var groupedParkSpots:[String:[ParkSpot]]!
    private var sectionTitles:[String]?
    private let defaultImage = UIImage(named: "park_default")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.scrollViewDidScroll(self.tableView)
        if self.groupedParkSpots == nil {
            DataManager.sharedManager.requestParkInfo(completion: { [weak self] (groupedSpots) in
                if groupedSpots != nil && groupedSpots!.count > 0 {
                    self?.groupedParkSpots = groupedSpots
                    self?.sectionTitles = Array(groupedSpots!.keys)
                    self?.tableView.reloadData()
                }else{
                    let noDataAlert = UIAlertController(title: "無法取得景點資料", message: "請稍候再試", preferredStyle: .alert)
                    noDataAlert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
                    self?.present(noDataAlert, animated: true, completion: nil)
                }
            })
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= 0 {
            self.title = ""
        }else{
            self.title = "台北市公園景點"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let sectionTitles = self.sectionTitles else {
            return 1 //loading
        }
        return sectionTitles.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionTitles = self.sectionTitles else {
            return 1 //loading
        }
        return self.groupedParkSpots[sectionTitles[section]]!.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sectionTitles = self.sectionTitles else {
            return nil
        }
        return sectionTitles[section]
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let park = self.sectionTitles?[indexPath.section], let spot = self.groupedParkSpots[park]?[indexPath.row] {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ParkListCell", for: indexPath) as! ParkListCell
            cell.parkSpot = spot
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingProgressCell", for: indexPath) as! LoadingProgressCell
        cell.loadingIndicator.startAnimating()
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show_spot_info" {
            if let itemCell = sender as? ParkListCell, let detailVC = segue.destination as? ParkSpotDetailViewController {
                detailVC.parkSpot = itemCell.parkSpot
            }
        }
        
    }

}
