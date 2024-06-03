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
    
    @IBOutlet weak var chatBubbleView: UIView!
    
    @IBOutlet weak var dateView: UIView!
    
    
    @IBOutlet weak var chatView: UIView!
    
    @IBOutlet weak var profileView: UIView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
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
        profileImageView.setLayoutForChatProfile()
        otherFirstNameLabel.setLayoutForChatTitle()
        otherFirstChatLabel.setLayoutForChatLabel()
        chatBubbleView.setLayoutForChatBubble()
        chatBubbleView.backgroundColor = .clear
        otherFirstTimeLabel.setLayoutForChatTimeLabel()
    }
    
    func configDateView(_ nowDate: Date, _ dateFormatter: DateFormatter) {
        dateView.snp.updateConstraints{
            $0.top.equalToSuperview().inset(5)
            $0.height.equalTo(20)
        }
        dateLabel.snp.updateConstraints {
            $0.top.equalToSuperview().inset(5)
        }
        dateLabel.textAlignment = .center
        dateLabel.font = .systemFont(ofSize: 10)
        dateLabel.textColor = .white
        dateLabel.layer.masksToBounds = true
        dateLabel.layer.cornerRadius = 10
        dateLabel.backgroundColor = .systemGray
        dateFormatter.dateFormat = "yyyy년 M월 d일"
        dateLabel.text = dateFormatter.string(from: nowDate)
    }
    
    
    func configCell(_ data: Chat, _ fastDate: String?, _ fastUser: User?, _ nextUser: User?) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: Locale.current.identifier)
        dateFormatter.dateStyle = .long
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        guard let nowDate = dateFormatter.date(from: data.date) else {return}
        
        if let fastDate {
            guard let lastDate = dateFormatter.date(from: fastDate) else {return}
            
            if lastDate.distance(to: nowDate) >= 86400 {
                configDateView(nowDate, dateFormatter)
            }
        } else {
            configDateView(nowDate, dateFormatter)
        }
        
        otherFirstChatLabel.text = data.message
        
        if data.user != fastUser {
            let name = data.user.rawValue
            otherFirstNameLabel.text = name
            profileImageView.image = UIImage(named: name)
        }
        
        if data.user != nextUser {
            guard let oldDate = dateFormatter.date(from: data.date) else {return}
            
            dateFormatter.dateFormat = "a h:mm"
            let newDate = dateFormatter.string(from: oldDate)
            
            otherFirstTimeLabel.text = newDate
        } else {
            otherFirstTimeLabel.text = ""
        }
    }
    
}
