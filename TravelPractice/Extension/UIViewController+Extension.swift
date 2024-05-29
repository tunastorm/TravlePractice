//
//  UIViewController+Extension.swift
//  TravlePractice
//
//  Created by 유철원 on 5/27/24.
//

import UIKit

extension UIViewController {
    
    // Can change status bar color
    func changeStatusBarBgColor(bgColor: UIColor?) {
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.first
            let statusBarManager = window?.windowScene?.statusBarManager
            
            let statusBarView = UIView(frame: statusBarManager?.statusBarFrame ?? .zero)
            statusBarView.backgroundColor = bgColor
            
            window?.addSubview(statusBarView)
        } else {
            let statusBarView = UIApplication.shared.value(forKey: "statusBar") as? UIView
            statusBarView?.backgroundColor = bgColor
        }
    }
    
    func setSafetyArea(_ safetyArea: UIView){
         safetyArea.translatesAutoresizingMaskIntoConstraints = false // 코드로 제약조건을 주기위해서 꼭 들어가야 하는 코드
         view.addSubview(safetyArea)
         if #available(iOS 11, *) {
             let guide = view.safeAreaLayoutGuide
             safetyArea.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
             safetyArea.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
             safetyArea.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
             safetyArea.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
             
         } else {
             safetyArea.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor).isActive = true
             safetyArea.bottomAnchor.constraint(equalTo: bottomLayoutGuide.bottomAnchor).isActive = true
             safetyArea.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
             safetyArea.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
         }
    }
}
