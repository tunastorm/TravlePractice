//
//  UIButton+Extension.swift
//  TravlePractice
//
//  Created by 유철원 on 5/27/24.
//

import UIKit

extension UIButton {
    func setLayoutForLikeList() {
        self.tag = 0
        self.layer.cornerRadius = self.frame.height * 0.1
        self.setTitle("", for: .normal)
        self.tintColor = .systemRed
        self.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        self.backgroundColor = .white
    }
    
    func setLayoutForLikeButton() {
        let image = UIImage(systemName: "heart")
        self.setImage(image, for: .normal)
        self.tintColor = .white
    }
}
