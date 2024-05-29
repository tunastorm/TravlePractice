//
//  TravelDescViewController.swift
//  TravlePractice
//
//  Created by 유철원 on 5/29/24.
//

import UIKit

class TravelDescViewController: UIViewController {

    static let identifier = String(String(describing: type(of: self)).split(separator: " ").last!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
    }
    
    func setNavigationBar() {
        navigationItem.setLayoutFortopTitle(title: "관광지 확인", width: view.frame.width, height: 40)
        
        let backWordButton = UIBarButtonItem(title: "←", style: .done, target: self, action: #selector(popButtonClicked))
        backWordButton.tintColor = .black
        navigationItem.leftBarButtonItems = [backWordButton]
    }
    
    
    @objc func popButtonClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }


}
