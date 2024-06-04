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
    
    @IBOutlet weak var chatBubbleView: UIView!
    
    @IBOutlet weak var chatView: UIView!
    
    @IBOutlet weak var dateView: UIView!
    
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
        myChatLabel.setLayoutForChatLabel()
        chatBubbleView.setLayoutForChatBubble()
        chatBubbleView.backgroundColor = .systemGray6
        myChatTimeLabel.setLayoutForChatTimeLabel()
    }
    
    func configDateView(_ nowDate: Date, _ dateFormatter: DateFormatter) {
        
        dateView.snp.updateConstraints{
            $0.height.equalTo(20)
//            $0.bottom.equalTo(chatView).inset(5)
        }
//        dateLabel.snp.updateConstraints{
//            $0.bottom.equalToSuperview().inset(5)
//        }
        
        dateLabel.layer.cornerRadius = 10
        dateLabel.backgroundColor = .systemGray
        dateLabel.layer.masksToBounds = true
        dateLabel.textColor = .white
        dateLabel.font = .systemFont(ofSize: 10)
        dateLabel.textAlignment = .center
        dateFormatter.dateFormat = "yyyy년 M월 d일"
        dateLabel.text = dateFormatter.string(from: nowDate)
    }
    
    
    func configCell(_ data: Chat, _ fastDate: String?, _ nextUser: User?) {
        
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
            print(#function + " \(data)")
            configDateView(nowDate, dateFormatter)
        }
        
        myChatLabel.text = data.message
        
        if data.user != nextUser {
            
            guard let oldDate = dateFormatter.date(from: data.date) else {return}
            
            dateFormatter.dateFormat = "a h:mm"
            let newDate = dateFormatter.string(from: oldDate)
            
            myChatTimeLabel.text = newDate
        } else {
            myChatTimeLabel.text = ""
        }
    }
}
