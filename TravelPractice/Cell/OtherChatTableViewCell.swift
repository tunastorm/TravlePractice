//
//  OtherChatTableViewCell.swift
//  TravlePractice
//
//  Created by 유철원 on 6/2/24.
//

import UIKit

class OtherChatTableViewCell: UITableViewCell {

    @IBOutlet weak var otherChatLabel: UILabel!
    @IBOutlet weak var otherChatTimeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configLayout()
    }

    func configLayout() {
        configLayoutForChatRoom()
        otherChatLabel.textAlignment = .left
        otherChatLabel.numberOfLines = 0
        otherChatLabel.backgroundColor = .systemGray4
        otherChatLabel.layer.cornerRadius = 5
        otherChatLabel.layer.masksToBounds = true
        otherChatTimeLabel.font = .systemFont(ofSize: 10)
    }
    
    func configCell(_ data: Chat, _ nextUser: User?) {
        
        otherChatLabel.text = data.message
        
        if data.user != nextUser {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: Locale.current.identifier)
            dateFormatter.dateStyle = .long
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            guard let oldDate = dateFormatter.date(from: data.date) else {return}
            
            dateFormatter.dateFormat = "a h:mm"
            let newDate = dateFormatter.string(from: oldDate)
            
            otherChatTimeLabel.text = newDate
        } else {
            otherChatTimeLabel.text = ""
        }
    }
    
}
