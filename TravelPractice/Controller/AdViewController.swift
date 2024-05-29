//
//  AdViewController.swift
//  TravlePractice
//
//  Created by 유철원 on 5/29/24.
//

import UIKit

class AdViewController: UIViewController {
    
    
    static let identifier = String(String(describing: type(of: self)).split(separator: " ").last!)

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
    }
    
    func setNavigationBar() {
        navigationItem.setLayoutFortopTitle(title: "광고", width: view.frame.width, height: 40)
        
        let backWordButton = UIBarButtonItem(title: "←", style: .done, target: self, action: #selector(dismissButtonClicked))
        backWordButton.tintColor = .black
        
        navigationItem.leftBarButtonItems = [backWordButton]
    }

  
    @objc func dismissButtonClicked(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
}
