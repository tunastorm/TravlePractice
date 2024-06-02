//
//  MyChatTableViewCell.swift
//  TravlePractice
//
//  Created by 유철원 on 6/1/24.
//

import UIKit

class OtherChatTableViewCell: UITableViewCell {

    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var chatView: UIView!
    @IBOutlet weak var chatLabel: UILabel!
    @IBOutlet weak var chatTimeLabel: UILabel!
    
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
        chatLabel.textAlignment = .left
        chatLabel.numberOfLines = 0
        chatLabel.backgroundColor = .lightGray
        chatLabel.layer.cornerRadius = 5
        chatLabel.layer.masksToBounds = true
    }
    
    func configCell(_ data: Chat, _ fastUser: User?, _ nextUser: User?) {
        
        chatLabel.text = data.message
        
        if data.user != fastUser {
            let name = data.user.rawValue
            nameLabel.text = name
            profileImageView.image = UIImage(named: name)
        }
        
        if data.user == nextUser {
            profileImageView.backgroundColor = .clear
            profileImageView.layer.borderWidth = 0
            nameLabel.frame.size = CGSize(width: nameLabel.frame.width, height: 0)
            nameLabel.text = ""
        }
        
        if data.user != nextUser {
            nameLabel.frame.size = CGSize(width: 0, height: 0)
            nameLabel.text = ""
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: Locale.current.identifier)
            dateFormatter.dateStyle = .long
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            guard let oldDate = dateFormatter.date(from: data.date) else {return}
            
            dateFormatter.dateFormat = "a h:mm"
            let newDate = dateFormatter.string(from: oldDate)
            
            chatTimeLabel.text = newDate
        }
    }
    
}
