//
//  AdViewController.swift
//  TravlePractice
//
//  Created by 유철원 on 5/29/24.
//

import UIKit

class AdViewController: UIViewController {
    
    @IBOutlet var adTitleLabel: UILabel!
    @IBOutlet var adImageView: UIImageView!
    
    var adTitle: String?
    var color: UIColor?
    
    let adImage = AdImageUrl().getRandom
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setAdView()
    }
    
    func setAdView() {
        adTitleLabel.text = adTitle
        adTitleLabel.textColor = .white
        adTitleLabel.font = .boldSystemFont(ofSize: 20)
        adTitleLabel.backgroundColor = color
        
        adImageView.kf.setImage(with: adImage)
        adImageView.contentMode = .scaleAspectFill
    }
    
    func setNavigationBar() {
        navigationItem.setLayoutFortopTitle(title: "광고", color: .black, width: view.frame.width, height: 40)
        
        let backWordButton = UIBarButtonItem(title: "←", style: .done, target: self, action: #selector(dismissButtonClicked))
        backWordButton.tintColor = .black
        
        navigationItem.leftBarButtonItems = [backWordButton]
        
        
        let imageview = UIImage()
    }

  
    @objc func dismissButtonClicked(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
}
