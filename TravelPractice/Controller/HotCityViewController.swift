//
//  HotCityViewController.swift
//  TravlePractice
//
//  Created by 유철원 on 5/27/24.
//

import UIKit

class HotCityViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    let list = TravelInfo().travel
    
    let hotCityIdentifier = HotCityTableViewCell.identifier
    let adIdentifier = AdTableViewCell.identifier
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        
        let hotCityXIB = UINib(nibName: hotCityIdentifier, bundle: nil)
        let adXIB = UINib(nibName: adIdentifier, bundle: nil)
        tableView.register(hotCityXIB, forCellReuseIdentifier: hotCityIdentifier)
        tableView.register(adXIB, forCellReuseIdentifier: adIdentifier)
    
        navigationItem.setLayoutFortopTitle(title: "도시 상세 정보", width: 100, height: 40)
    }
}

extension HotCityViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rowIndex = indexPath.row
        let data = list[rowIndex]
        
        var cell = UITableViewCell()
        if let isAd = data.ad, isAd {
            let adCell = tableView.dequeueReusableCell(withIdentifier: adIdentifier,
                                                            for: indexPath) as! AdTableViewCell
            adCell.configCell(data)
            cell = adCell
        } else {
            let hotCityCell = tableView.dequeueReusableCell(withIdentifier: hotCityIdentifier,
                                                       for: indexPath) as!  HotCityTableViewCell
            hotCityCell.configCell(data)
            
            cell = hotCityCell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = list[indexPath.row]
        
        if let isAD = data.ad, isAD {
            let sb = UIStoryboard(name: "Advertisement", bundle: nil)
            let identifier = AdViewController.identifier
            print(identifier)
            let vc = sb.instantiateViewController(withIdentifier: identifier) as! AdViewController
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        } else {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let identifier = TravelDescViewController.identifier
            let vc = sb.instantiateViewController(withIdentifier: identifier) as! TravelDescViewController
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
