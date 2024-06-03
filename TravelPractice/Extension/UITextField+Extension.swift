//
//  UITextField+Extension.swift
//  TravlePractice
//
//  Created by 유철원 on 5/27/24.
//

import UIKit

extension UITextField {
    func setLayoutForSearchBar() {
        if !self.isFirstResponder {
            self.becomeFirstResponder()
        }
        self.placeholder = Placeholder.restaurantSearch.text
        self.layer.cornerRadius = self.frame.height * 0.1
        self.backgroundColor = .systemGray6
        self.borderStyle = .none
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: self.frame.height))
        let imageName = "magnifyingglass"
        let image = UIImage(systemName: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 10, y: 7, width: 20, height: 20)
        imageView.tintColor = .gray
        paddingView.addSubview(imageView)
        paddingView.bringSubviewToFront(imageView)

        self.leftView = paddingView
        self.leftViewMode = UITextField.ViewMode.always
    }
}
