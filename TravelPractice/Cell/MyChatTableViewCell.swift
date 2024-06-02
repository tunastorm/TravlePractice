//
//  MyChatTableViewCell.swift
//  TravlePractice
//
//  Created by 유철원 on 6/1/24.
//

import UIKit

class MyChatTableViewCell: UITableViewCell {

    @IBOutlet weak var myChatLabel: UILabel!
    @IBOutlet weak var myChatTimeLabel: UILabel!
    
    
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
        myChatLabel.textAlignment = .left
        myChatLabel.numberOfLines = 0
        myChatLabel.backgroundColor = .yellow
        myChatLabel.layer.cornerRadius = 10
        myChatLabel.layer.masksToBounds = true
    }
    
    func configCell(_ data: Chat, _ nextUser: User?) {
        
        myChatLabel.text = data.message
        
        if data.user != nextUser {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: Locale.current.identifier)
            dateFormatter.dateStyle = .long
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            guard let oldDate = dateFormatter.date(from: data.date) else {return}
            
            dateFormatter.dateFormat = "a h:mm"
            let newDate = dateFormatter.string(from: oldDate)
            
            myChatTimeLabel.text = newDate
        } else {
            myChatTimeLabel.text = ""
        }
    }
}
