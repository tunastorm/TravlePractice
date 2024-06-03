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
    
    @IBOutlet weak var chatBubbleView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configLayout()
    }

    func configLayout() {
        configLayoutForChatRoom()
        otherChatLabel.setLayoutForChatLabel()
        chatBubbleView.setLayoutForChatBubble()
        chatBubbleView.backgroundColor = .clear
        otherChatTimeLabel.setLayoutForChatTimeLabel()
    }
    
    func setDateLabelLayout() {
        dateLabel.snp.updateConstraints{
            $0.bottom.equalTo(chatBubbleView).inset(5)
            $0.height.equalTo(20)
        }
        dateLabel.layer.cornerRadius = dateLabel.frame.height * 0.5
        dateLabel.layer.borderWidth = 1
        dateLabel.layer.borderColor = UIColor.systemGray3.cgColor
    }
    
    
    func configCell(_ data: Chat, _ fastDate: String?, _ nextUser: User?) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: Locale.current.identifier)
        dateFormatter.dateStyle = .long
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        guard let fastDate else { return }
        
        guard let lastDate = dateFormatter.date(from: fastDate) else {return}
        guard let nowDate = dateFormatter.date(from: data.date) else {return}
        
        if nowDate > lastDate {
            setDateLabelLayout()
            dateLabel.text = data.date
        }
        
        otherChatLabel.text = data.message
    
        if data.user != nextUser {
            guard let oldDate = dateFormatter.date(from: data.date) else {return}
            
            dateFormatter.dateFormat = "a h:mm"
            let newDate = dateFormatter.string(from: oldDate)
            
            otherChatTimeLabel.text = newDate
        } else {
            otherChatTimeLabel.text = ""
        }
    }
    
}
