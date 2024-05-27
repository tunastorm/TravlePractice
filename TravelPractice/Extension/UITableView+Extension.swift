//
//  UITableView + Extension.swift
//  TravlePractice
//
//  Created by 유철원 on 5/27/24.
//

import UIKit

extension UITableView {
    func setLayoutforRestaurant(){
        //tableView.rowHeight = UITableView.automaticDimension
        //tableView.estimatedRowHeight = 80
        self.separatorStyle = .none
        self.separatorColor = .gray
        self.backgroundColor = .systemGray6
        self.sectionHeaderTopPadding = 5
        self.sectionHeaderHeight = 5
        self.sectionFooterHeight = 5
    }
}
