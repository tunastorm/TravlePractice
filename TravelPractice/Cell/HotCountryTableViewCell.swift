//
//  HotCountryTableViewCell.swift
//  TravlePractice
//
//  Created by 유철원 on 5/29/24.
//

import UIKit

class HotCountryTableViewCell: UITableViewCell {

    @IBOutlet var mainImageCoverView: UIView!
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var citiesLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configLayout()
    }

    func configLayout() {
        mainImageView.setLayoutForCellMainImage()
        
        mainImageCoverView.backgroundColor = .black
        mainImageCoverView.layer.opacity = 0.4
        mainImageCoverView.layer.cornerRadius = mainImageCoverView.frame.height * 0.05
        
        countryLabel.font = .boldSystemFont(ofSize: 20)
        countryLabel.textAlignment = .right
        countryLabel.textColor = .white
        countryLabel.layer.cornerRadius = countryLabel.frame.height * 0.05
        
        citiesLabel.font = .systemFont(ofSize: 12)
        citiesLabel.textAlignment = .left
        citiesLabel.textColor = .white
        citiesLabel.backgroundColor = .black
        citiesLabel.layer.opacity = 0.5
        citiesLabel.layer.masksToBounds = true
        citiesLabel.layer.cornerRadius = citiesLabel.frame.height * 0.2
    }
    
    func configCell(_ data: City) {
        let url = URL(string: data.city_image)
        mainImageView.kf.setImage(with: url)
        countryLabel.text = "\(data.city_name) | \(data.city_english_name)"
        citiesLabel.text = "  " + data.city_explain
    }
    
    func configfilterredCell(_ data: City, filter: String) {
        configCell(data)
        
        if let country = countryLabel.text, country.contains(filter) {
            var attributedStr = NSMutableAttributedString(string: country)
            attributedStr.addAttribute(.foregroundColor, value: UIColor.systemMint, range: (country as NSString).range(of: filter))
            countryLabel.attributedText = attributedStr
        }
        
        if let cities = citiesLabel.text, cities.contains(filter) {
            var attributedStr = NSMutableAttributedString(string: cities)
            attributedStr.addAttribute(.foregroundColor, value: UIColor.systemMint, range: (cities as NSString).range(of: filter))
            citiesLabel.attributedText = attributedStr
        }
    }
}
