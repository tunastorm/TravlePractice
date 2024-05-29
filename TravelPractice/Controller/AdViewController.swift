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

        
    }

    @IBAction
    func dismissButtonClicked(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
}
