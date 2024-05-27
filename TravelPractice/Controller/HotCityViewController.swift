//
//  HotCityViewController.swift
//  TravlePractice
//
//  Created by 유철원 on 5/27/24.
//

import UIKit

class HotCityViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    let list = TravelInfo().travel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        let hotCityXIB = UINib(nibName: "HotCityTableViewCell", bundle: nil)
        let adXIB = UINib(nibName: "AdTableViewCell", bundle: nil)
        tableView.register(hotCityXIB, forCellReuseIdentifier: "HotCityTableViewCell")
        tableView.register(adXIB, forCellReuseIdentifier: "AdTableViewCell")
        navigationItem.setLayoutFortopTitle(title: "도시 상세 정보", width: 362, height: 40)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let data = list[indexPath.row]
        
        if let isAd = data.ad, isAd {
            return 70
        } else {
            return 140
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rowIndex = indexPath.row
        let data = list[rowIndex]
        
        var cell = UITableViewCell()
        if let isAd = data.ad, isAd {
            let adCell = tableView.dequeueReusableCell(withIdentifier: "AdTableViewCell",
                                                            for: indexPath) as! AdTableViewCell
            adCell.configCell(data)
            cell = adCell
        } else {
            let hotCityCell = tableView.dequeueReusableCell(withIdentifier: "HotCityTableViewCell",
                                                       for: indexPath) as!  HotCityTableViewCell
            hotCityCell.configCell(data)
            
            cell = hotCityCell
        }
        
        return cell
    }
    
    
}
