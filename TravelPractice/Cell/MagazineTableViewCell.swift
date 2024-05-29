//
//  MagazineTableViewCell.swift
//  TravlePractice
//
//  Created by 유철원 on 5/25/24.
//

import UIKit

class MagazineTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: type(of: self))
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var travelImageView: UIImageView!
    
    
    override func awakeFromNib() {
        configLayout()
    }
    
    func configLayout() {
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        
        subtitleLabel.textColor = .systemGray3
        dateLabel.font = .systemFont(ofSize: 12)
        
        travelImageView.contentMode = .scaleAspectFill
        travelImageView.layer.cornerRadius = travelImageView.frame.height * 0.05
    }
    
    func configCell(_ data: Magazine) {
        titleLabel.text = data.title
        subtitleLabel.text = data.subtitle
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: Locale.current.identifier)
        dateFormatter.dateStyle = .long
        
        dateFormatter.dateFormat = "yyMMdd"
        guard let newDate = dateFormatter.date(from: data.date) else {
            return
        }
        
        dateFormatter.dateFormat = "yy년 MM월 d일"
        dateLabel.text = dateFormatter.string(from: newDate)
        
        guard let url = URL(string: data.photo_image) else {
            return
        }
        travelImageView.kf.setImage(with: url,
                                   placeholder: UIImage(systemName: "camera"))
    }

}
