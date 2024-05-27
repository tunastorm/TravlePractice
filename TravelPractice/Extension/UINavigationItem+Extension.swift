//
//  UINavigationItem+Extension.swift
//  TravlePractice
//
//  Created by 유철원 on 5/28/24.
//

import UIKit

extension UINavigationItem {
    func setLayoutFortopTitle(title: String, width: Double, height: Double) {
        let topTitle = UILabel(frame:CGRect(x: 0, y: 0, width: width, height: height))
        topTitle.text = title
        topTitle.textColor = .black
        topTitle.textAlignment = .center
        topTitle.font = .boldSystemFont(ofSize: 20)
        let titleView = UIView(frame:CGRect(x: 0, y: 0, width: width, height: height)) ?? UIView()
        titleView.addSubview(topTitle)
        titleView.bringSubviewToFront(topTitle)
        self.titleView = titleView
        topTitle.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
