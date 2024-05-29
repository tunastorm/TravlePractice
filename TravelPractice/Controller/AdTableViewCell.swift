//
//  AdTableViewCell.swift
//  TravlePractice
//
//  Created by 유철원 on 5/27/24.
//

import UIKit

class AdTableViewCell: UITableViewCell {

    @IBOutlet weak var copyLabel: UILabel!
    @IBOutlet weak var adLabel: UILabel!
    
    let colors: [UIColor] = [.systemGray, .systemMint, .systemPink, .systemIndigo]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configLayout()
    }
    
    func configLayout() {
        contentView.backgroundColor = colors.randomElement()!
        contentView.layer.cornerRadius = contentView.frame.height * 0.1
        
        adLabel.text = "AD"
        adLabel.textColor = .black
        adLabel.textAlignment = .center
        adLabel.font = .boldSystemFont(ofSize: 15)
        adLabel.backgroundColor = .white
        adLabel.layer.masksToBounds = true
        adLabel.layer.cornerRadius = adLabel.frame.height * 0.4
        
        copyLabel.textColor = .black
        copyLabel.textAlignment = .center
        copyLabel.font = .boldSystemFont(ofSize: 15)
        copyLabel.numberOfLines = 0
    }
    
    func configCell(_ data: Travel) {
        copyLabel.text = "\(data.title)"
    }
}
