//
//  RestaurantTableViewCell.swift
//  TravlePractice
//
//  Created by 유철원 on 5/25/24.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet weak var restaurantImage: UIImageView!
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configLayout()
    }
    
    func configLayout() {
        self.configCellForRestaurant()
        
        restaurantImage.contentMode = .scaleAspectFill
        restaurantImage.layer.cornerRadius = restaurantImage.frame.height * 0.05
        
        categoryLabel.textAlignment = .left
        categoryLabel.font = .systemFont(ofSize: 10)
        categoryLabel.textColor = .gray
        
        nameLabel.textAlignment = .left
        nameLabel.font = .boldSystemFont(ofSize: 15)
        
        addressLabel.textAlignment = .left
        addressLabel.font = .systemFont(ofSize: 10)
        addressLabel.textColor = .gray
        
        phoneNumberLabel.textAlignment = .left
        phoneNumberLabel.font = .systemFont(ofSize: 10)
        phoneNumberLabel.textColor = .gray
        
        priceLabel.textAlignment = .left
        priceLabel.font = .systemFont(ofSize: 10)
        priceLabel.textColor = .gray
    }
    
    func configCell(_ row: Restaurant, rowIndex: Int) {
        // print("isSearchResult: \(restaurantCRUD.getIsSearchResult())")
//        print("isLikeResult: \(isLikeResult)")
        
        print("beforeSetCell: \(row.name)")
        
        let url = URL(string: row.image)
        restaurantImage.kf.setImage(with: url)
        
        categoryLabel.text = row.category
        
        nameLabel.text = row.name
        
        addressLabel.text = row.address
        
        phoneNumberLabel.text = row.phoneNumber
        
        priceLabel.text = "평균 " + row.price.formatted() + "원"
        
        likeButton.tag = rowIndex
        let image = row.like ? "heart.fill" : "heart"
        if row.like {
            likeButton.tintColor = .systemRed
        }
        likeButton.setImage(UIImage(systemName: image), for: .normal)
        
    }
}
