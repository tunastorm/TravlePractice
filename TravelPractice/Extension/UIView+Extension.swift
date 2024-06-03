//
//  UIView+Extension.swift
//  TravlePractice
//
//  Created by 유철원 on 6/3/24.
//

import UIKit

extension UIView {
    func setLayoutForChatBubble() {
        self.layer.cornerRadius = self.frame.height * 0.4
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemGray3.cgColor
        self.layer.masksToBounds = true
    }
}
