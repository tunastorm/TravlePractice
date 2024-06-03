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
    
    func setLayoutForChatTitle() {
        self.font = .boldSystemFont(ofSize: 12)
    }
    
    func setLayoutForChatSubTitle() {
        self.font = .systemFont(ofSize: 12)
        self.textColor = .systemGray2
    }
    
    func setLayoutForChatTimeLabel() {
        self.font = .systemFont(ofSize: 10)
        self.textColor = .systemGray2
    }
    
    func setLayoutForChatLabel() {
        self.font = .systemFont(ofSize: 12)
        self.textAlignment = .left
        self.numberOfLines = 0
    }
}
