//
//  UIImageView+Extension.swift
//  TravlePractice
//
//  Created by 유철원 on 5/27/24.
//

import UIKit

extension UIImageView {
    func setLayoutForCellMainImage() {
        self.layer.cornerRadius = self.frame.height * 0.05
        self.contentMode = .scaleAspectFill
    }
    
    func setLayoutForStarReview() {
        self.contentMode = .scaleAspectFit
        self.tintColor = .systemYellow
    }
}
