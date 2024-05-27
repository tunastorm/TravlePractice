//
//  SearchRestaurantTableViewCell.swift
//  TravlePractice
//
//  Created by 유철원 on 5/25/24.
//

import UIKit

class SearchRestaurantTableViewCell: UITableViewCell {

    @IBOutlet weak var currentKeywordLabel: UILabel!
    
    func configLayout() {
        currentKeywordLabel.font = .boldSystemFont(ofSize: 15)
        currentKeywordLabel.textAlignment = .left
    }
    
    func configCell() {
        currentKeywordLabel.text = "최근 검색어"
        
    }
    
}
