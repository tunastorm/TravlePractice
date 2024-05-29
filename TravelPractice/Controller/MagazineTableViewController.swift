//
//  MagazineTableViewController.swift
//  TravlePractice
//
//  Created by 유철원 on 5/25/24.
//

import UIKit

import Kingfisher

class MagazineTableViewController: UITableViewController {
    
    
    @IBOutlet weak var MagazineTableViewTitle: UILabel!
    
    @IBOutlet weak var titleView: UIView!
    
    var magazineList = MagazineDAO()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 0
        navigationItem.setLayoutFortopTitle(title: "SeSAC TRAVEL", width: tableView.frame.width, height: 40)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
   
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return magazineList.getCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rowIndex = indexPath.row
        
        let data = magazineList.getmagazine(at: rowIndex)
        
//        print("[cell_\(rowIndex)]\n\(row)")
        
        let identifier = CellIdentifier.MagazineTableViewCell.describe
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MagazineTableViewCell
        
        if tableView.rowHeight == 0 {
            tableView.rowHeight = cell.frame.height
        }

        cell.configCell(data)

        return cell
    }
    


}
