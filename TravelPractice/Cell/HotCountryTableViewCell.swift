//
//  HotCountryTableViewCell.swift
//  TravlePractice
//
//  Created by 유철원 on 5/29/24.
//

import UIKit

class HotCountryTableViewCell: UITableViewCell {

    static let identifier = String(String(describing: type(of: self)).split(separator: " ").last!)

    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var countryLavel: UILabel!
    @IBOutlet var citiesLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configLayout() {
        
    }
    
    func configCell() {
        
    }
}
