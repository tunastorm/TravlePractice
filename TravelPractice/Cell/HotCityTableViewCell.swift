//
//  HotCityTableViewCell.swift
//  TravlePractice
//
//  Created by 유철원 on 5/27/24.
//

import UIKit

class HotCityTableViewCell: UITableViewCell {
    
    static let identifier = String(String(describing: type(of: self)).split(separator: " ").last!)
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var starAndSavedLabel: UILabel!
    
    @IBOutlet var starStackView: UIStackView!
    
    @IBOutlet var mainImageView: UIImageView!
    
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configLayout()
    }
    
    func configLayout() {
        titleLabel.setLayoutForCellTitle()
        descriptionLabel.setLayoutForCellDescription()
        mainImageView.setLayoutForCellMainImage()
        starAndSavedLabel.setLayoutForCellStarAndSaved()
        likeButton.setLayoutForLikeButton()
        
        for star in starStackView.arrangedSubviews {
            let imageView = star as! UIImageView
            imageView.setLayoutForStarReview()
        }
    }
    
    func configCell(_ data: Travel) {
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        
        guard let grade = data.grade,
              let saved = data.save?.formatted() else {
                  return
              }
        starAndSavedLabel.text = "\(grade) · 저장 \(saved)"
        
        var gradeCopy = grade
        for (idx, star) in starStackView.arrangedSubviews.enumerated() {
            let imageView = star as! UIImageView
            var image: UIImage
            
            if (gradeCopy - 1) >= 0 {
                image = UIImage(systemName: "star.fill")!.withRenderingMode(.alwaysOriginal)
                gradeCopy -= 1
            } else {
                image = UIImage(systemName: "star")!.withRenderingMode(.alwaysOriginal)
//                var bgImage = UIImage(systemName: "star.fill")!.withTintColor(.red)
//                imageView.backgroundColor = UIColor(patternImage: bgImage)
            }
            
            imageView.image = image
        }
        
        guard let image = data.travel_image else {
            return
        }
        
        let url = URL(string: image)
        mainImageView.kf.setImage(with: url,
                                  placeholder: UIImage(systemName: "camera"))
    }
}

