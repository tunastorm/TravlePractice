//
//  UITableViewCell+Extension.swift
//  TravlePractice
//
//  Created by 유철원 on 5/27/24.
//

import UIKit


extension UITableViewCell {
    
    func configCellForRestaurant() {
        self.selectionStyle = .none
        self.backgroundColor = .white
        self.tintColor = .black
        self.textLabel?.font = .systemFont(ofSize: 12)
        
    }
}
