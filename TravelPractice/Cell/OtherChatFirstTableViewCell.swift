//
//  MyChatTableViewCell.swift
//  TravlePractice
//
//  Created by 유철원 on 6/1/24.
//

import UIKit

class OtherChatFirstTableViewCell: UITableViewCell {

    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var otherFirstNameLabel: UILabel!
    @IBOutlet weak var otherFirstChatLabel: UILabel!
    @IBOutlet weak var otherFirstTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configLayout()
//        layoutSubviews()
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
//    }
    
    func configLayout() {
        configLayoutForChatRoom()
        profileImageView.layer.cornerRadius = 10
        profileImageView.contentMode = .scaleAspectFill
        otherFirstChatLabel.textAlignment = .left
        otherFirstChatLabel.numberOfLines = 0
        otherFirstChatLabel.backgroundColor = .lightGray
        otherFirstChatLabel.layer.cornerRadius = 5
        otherFirstChatLabel.layer.masksToBounds = true
    }
    
    func configCell(_ data: Chat, _ fastUser: User?, _ nextUser: User?) {
        
        otherFirstChatLabel.text = data.message
        
        if data.user != fastUser {
            let name = data.user.rawValue
            otherFirstNameLabel.text = name
            profileImageView.image = UIImage(named: name)
        }
        
        if data.user == nextUser {
            profileImageView.backgroundColor = .clear
            profileImageView.layer.borderWidth = 0
            otherFirstNameLabel.frame.size = CGSize(width: otherFirstNameLabel.frame.width, height: 0)
            otherFirstNameLabel.text = ""
        }
        
        if data.user != nextUser {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: Locale.current.identifier)
            dateFormatter.dateStyle = .long
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            guard let oldDate = dateFormatter.date(from: data.date) else {return}
            
            dateFormatter.dateFormat = "a h:mm"
            let newDate = dateFormatter.string(from: oldDate)
            
            otherFirstTimeLabel.text = newDate
        } else {
            otherFirstTimeLabel.text = ""
        }
    }
    
}
