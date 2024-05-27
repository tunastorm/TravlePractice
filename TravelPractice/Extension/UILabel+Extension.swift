//
//  UILabel+Extension.swift
//  TravlePractice
//
//  Created by 유철원 on 5/27/24.
//

import UIKit

extension UILabel {
    func setLayoutForCellTitle() {
        self.textColor = .black
        self.textAlignment = .left
        self.font = .boldSystemFont(ofSize: 15)
    }
    
    func setLayoutForCellDescription() {
        self.textColor = .gray
        self.textAlignment = .left
        self.font = .systemFont(ofSize: 12)
        self.numberOfLines = 0
    }
    
    func setLayoutForCellStarAndSaved(){
        self.textColor = .lightGray
        self.font = .systemFont(ofSize: 10)
        self.textAlignment = .left
    }
}
